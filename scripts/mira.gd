extends CharacterBody2D
class_name TargetPoint

@export var target_locate = Vector2.ZERO
@export var speed = 7000

func go_to(local: Vector2 = target_locate):
	target_locate = local
	var delta = get_process_delta_time()
	
	velocity = global_position.direction_to(target_locate) * speed * delta
	
	if global_position.distance_to(target_locate) < 1:
		velocity = Vector2.ZERO
	
	move_and_slide()
	Global.apontar = self.global_position
