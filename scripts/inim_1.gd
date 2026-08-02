extends CharacterBody2D
class_name Enemie

@export var sprite : Sprite2D

@export var velocidade : int = randi_range(30,50)
@export var vida : int = randi_range(5,25)
@export var dano : int = randi_range(1,9)

@export var velocity_range : Vector2i = Vector2i(30,50)
@export var life_range : Vector2i = Vector2i(5,25)
@export var damage_range : Vector2i = Vector2i(1,9)
#var alter_all : Dictionary = {0:"res://sprites/Personagens/inim_4.png",1:"res://sprites/Personagens/inv player.png"}
#var alter_all_int := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position.x = randi_range(0,96)
	#alterar_spt()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#look_at(Vector2(48,144))
	#if self.global_position.distance_to(Vector2(48,144)) > 5 and vida > 0:
		#self.global_position += transform.x * velocidade * delta
	##print(self.global_position )
	#if vida <= 0 or Global.reinicio:
		#restart()
	#if alter_all_int != Global.alterar_sprites:
		#alterar_spt()
	#pass

func restart():
	if vida <= 0 :
		Global.score += 1
	self.global_position = Vector2(randi_range(0,96),-300)
	vida = randi_range(5,25)
	dano = randi_range(1,9)
	velocidade = randi_range(30,50)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		vida -= body.dano
		sprite.modulate = Color(1.0,1.0,1.0)
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color(0.773, 0.024, 0.055)
		
		
#func alterar_spt():
	#alter_all_int = Global.alterar_sprites
	#sprite.set_texture(load(alter_all[alter_all_int]))
