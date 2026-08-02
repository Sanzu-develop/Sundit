extends Node2D

@export var points_node : Node2D
@export var poly : Polygon2D

var points = [
	Vector2(0, 0),
	Vector2(100, 0),
	Vector2(80, 50),
	Vector2(0, 60)
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points.clear()
	for i in points_node.get_children():
		points.append(i.position)
		pass
		
	var Poly = Polygon2D.new()
	Poly.polygon = points
	Poly.color = Color.AQUAMARINE
	add_child(Poly)
	poly = Poly
	pass # Replace with function body.


#func _draw():
	#draw_polygon(points, [Color.CRIMSON])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
