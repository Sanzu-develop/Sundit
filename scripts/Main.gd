extends Node2D

@export var player : Player
@export var target_point : TargetPoint
@export var lbl : Label

@export var touching_input : Dictionary
@export var rotation_sensibility : float = 0.1
var radius_target_point 

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			touching_input[event.index] = {"touch_position": get_global_mouse_position()}
		else:
			if touching_input.has(event.index): touching_input.erase(event.index)
	
	elif event is InputEventScreenDrag:
		if touching_input.has(event.index): 
			touching_input[event.index]["drag_position"] = get_global_mouse_position()
			touching_input[event.index]["drag_relative"] = event.relative
	
	manage_validate()
	#if touching_input.has(0) and touching_input[0].has("drag_position"): validate_vector(touching_input[0]["drag_position"])

func manage_validate():
	for index in touching_input.keys():
		var touch_data = touching_input[index]
		
		if not touch_data.has("drag_relative"):
			radius_target_point = target_point.global_position.length()
		
		if touch_data.has("touch_position") and touch_data["touch_position"].y < 0:
			var target_vec = touch_data["drag_position"] if touch_data.has("drag_position") else touch_data["touch_position"]
			target_point.go_to(target_vec)
			#touch_data.erase("touch_position")
		
		elif touch_data.has("drag_relative"):
			var relative = touch_data["drag_relative"]
			
			#var radius = target_point.global_position.length()
			var angle = target_point.global_position.angle()
			
			var move_angle = angle + (relative.x * rotation_sensibility)
			
			target_point.go_to(Vector2(cos(move_angle),sin(move_angle)) * radius_target_point)
			
			touch_data.erase("drag_relative")

func validate_vector(vec: Vector2):
	if vec.y > 150: print(vec)
	lbl.text = str(vec.y)
