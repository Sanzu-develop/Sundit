extends CharacterBody2D
class_name TargetPoint

@export var target_locate = Vector2.ZERO
@export var speed = 100

var running : bool = false
var go_in_running : bool = false

var tween : Tween

signal path_initiate
signal path_runing
signal path_ended

func go_to(local: Vector2):
	if tween and tween.is_running():
		tween.kill()
	
	go_in_running = false
	target_locate = local
	
	tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(self,"global_position",local,0.25)

	path_initiate.emit()
	
	await tween.finished
	
	path_ended.emit()

func go_in(move: Vector2):
	if tween and tween.is_running():
		tween.kill()
	
	target_locate = move
	
	go_in_running = true
	
	path_initiate.emit()

func _physics_process(delta: float) -> void:
	if go_in_running:
		if global_position.distance_to(target_locate) < 2.0:
			velocity = Vector2.ZERO
			global_position = target_locate
		else:
			var direction = global_position.direction_to(target_locate)
			var distance = global_position.distance_to(target_locate)
			velocity = direction * min(distance / delta, speed)
	else:
		velocity = Vector2.ZERO
	if running: 
		path_runing.emit()
	
	move_and_slide()
	Global.apontar = self.global_position

func _on_path_initiate() -> void:
	running = true

func _on_path_ended() -> void:
	running = false
