extends Node2D

@export var player : Player
@export var target_point : TargetPoint
@export var lbl : Label

@export var touching_input : Dictionary

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			touching_input[event.index] = {"touch_position": event.position}
		else:
			if touching_input.has(event.index): touching_input.erase(event.index)
	
	elif event is InputEventScreenDrag:
		if touching_input.has(event.index): 
			touching_input[event.index]["drag_position"] = event.position
			touching_input[event.index]["drag_relative"] = event.relative
	
	if touching_input.has(0) and touching_input[0].has("drag_position"): validate_vector(touching_input[0]["drag_position"])

func validate_vector(vec: Vector2):
	if vec.y > 150: print(vec)
	lbl.text = str(vec.y)
