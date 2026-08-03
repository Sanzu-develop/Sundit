extends CharacterBody2D
class_name TargetPoint

@export var next_locate : Dictionary[String,Vector2] = {"local": self.global_position, "to": Vector2.ZERO}
@export var target_locate = Vector2.ZERO
@export var speed = 7000

var running : bool = false

signal path_initiate
signal path_runing
signal path_ended

func go_to(local: Vector2):
	next_locate["to"] = local
	looping()

func looping():
	if running: return
	
	target_locate = next_locate["to"]
	var delta = get_process_delta_time()
	
	path_initiate.emit()
	
	velocity = (global_position + target_locate).normalized() * speed * delta
	
	set_physics_process(true)

func _physics_process(_delta: float) -> void:
	path_runing.emit()
	if global_position.distance_to(target_locate) < 5:
		set_physics_process(false)
		velocity = Vector2.ZERO
		path_ended.emit()
		if next_locate["to"] != next_locate["local"]:
			looping()
	
	move_and_slide()
	Global.apontar = self.global_position

func _on_path_initiate() -> void:
	next_locate["local"] = self.global_position
	running = true

func _on_path_ended() -> void:
	next_locate["local"] = self.global_position
	running = false
