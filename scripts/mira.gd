extends CharacterBody2D
class_name TargetPoint

@export var target_locate = Vector2.ZERO
@export var speed = 7000

var running : bool = false

var tween : Tween

signal path_initiate
signal path_runing
signal path_ended

func go_to(local: Vector2):
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(self,"global_position",local,0.25)

	path_initiate.emit()
	
	await tween.finished
	
	path_ended.emit()

func _physics_process(_delta: float) -> void:
	if running: path_runing.emit()
	
	Global.apontar = self.global_position

func _on_path_initiate() -> void:
	running = true

func _on_path_ended() -> void:
	running = false
