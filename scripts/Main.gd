extends Node2D

@export var player : Player
@export var target_point : TargetPoint
@export var lbl : Label

@export var touching_input : Dictionary
@export var rotation_sensibility : float = 1.0
var radius_target_point : float

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			touching_input[event.button_index] = {"touch_position": get_global_mouse_position()}
			if get_global_mouse_position().y <= 0: radius_target_point = target_point.global_position.length()
		else:
			if touching_input.has(event.button_index): touching_input.erase(event.button_index)
	if event is InputEventScreenTouch:
		if event.pressed:
			touching_input[event.index] = {"touch_position": get_global_mouse_position()}
			if get_global_mouse_position().y <= 0: radius_target_point = target_point.global_position.length()
		else:
			if touching_input.has(event.index): touching_input.erase(event.index)
	
	#elif event is InputEventScreenDrag or event is InputEventMouseMotion:
	elif event is InputEventScreenDrag and touching_input.has(event.index): 
			touching_input[event.index]["drag_position"] = get_global_mouse_position()
			touching_input[event.index]["drag_relative"] = event.relative
	elif event is InputEventMouseMotion and touching_input.has(0): 
			touching_input[0]["drag_position"] = get_global_mouse_position()
			#if event is InputEventMouseMotion: print(event.velocity)
			touching_input[0]["drag_relative"] = event.relative
	
	manage_validate()
	#if touching_input.has(0) and touching_input[0].has("drag_position"): validate_vector(touching_input[0]["drag_position"])

func manage_validate():
	for index in touching_input.keys():
		var touch_data = touching_input[index]
		
		if touch_data.has("touch_position") and touch_data["touch_position"].y > 0:
			#print(touch_data["touch_position"].y)
			player.use_gun()
			
			if touch_data.has("drag_relative"):
				var relative = touch_data["drag_relative"]
				
				#var radius = target_point.global_position.length()
				var angle = target_point.global_position.angle()
				
				var move_angle = angle + (relative.x * rotation_sensibility)
				
				target_point.go_in(Vector2(cos(move_angle),sin(move_angle)) * (radius_target_point * 1.0))
				
				touch_data.erase("drag_relative")

		elif touch_data.has("touch_position") and touch_data["touch_position"].y < 0:
				var target_vec = touch_data["drag_position"] if touch_data.has("drag_position") else touch_data["touch_position"]
				target_point.go_to(target_vec)
			
			
			#touch_data.erase("touch_position")

func validate_vector(vec: Vector2):
	if vec.y > 150: print(vec)
	lbl.text = str(vec.y)
