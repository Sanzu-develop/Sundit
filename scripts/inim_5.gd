extends CharacterBody2D
class_name inim_5

@export var spr : Sprite2D
@onready var sprite = $AnimationPlayer
@onready var sprites : Array = ["res://sprites/Personagens/bomb1.png","res://sprites/Personagens/bomb2.png","res://sprites/Personagens/bomb3.png","res://sprites/Personagens/explo.png"]
var velocidade = randi_range(20,40) * 2
var vida = randi_range(10,15)
var dano = randi_range(4,5)
var alter_all : Dictionary = {0:"default",1:"inv"}
var alter_all_int := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position.x = randi_range(0,96)
	alterar_spt()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(Vector2(48,144))
	if self.global_position.distance_to(Vector2(48,144)) > 5 and vida > 0 and Global.score > 5:
		self.global_position += transform.x * velocidade * delta
	#print(self.global_position )
	if vida <= 0 or Global.reinicio:
		restart()
	if alter_all_int != Global.alterar_sprites:
		alterar_spt()
	pass

func restart():
	if vida <= 0 :
		dano = dano * 2
		#self.scale = Vector2(2.0,2.0)
		sprite.play("explosion")
		await sprite.animation_finished
		sprite.play(alter_all[alter_all_int])
		#await get_tree().create_timer(0.2).timeout
		#self.scale = Vector2(1.0,1.0)
	self.global_position = Vector2(randi_range(0,96),-300)
	vida = randi_range(10,15)
	dano = randi_range(4,5)
	velocidade = randi_range(20,40) * 2
	Global.score += 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		vida -= body.dano
		spr.modulate = Color(1.0,1.0,1.0)
		await get_tree().create_timer(0.1).timeout
		spr.modulate = Color(0.557, 0.769, 0.188)
		
	if not body.is_in_group("player"):
		body.vida -= dano
		
func alterar_spt():
	alter_all_int = Global.alterar_sprites
	sprite.play(alter_all[alter_all_int])
