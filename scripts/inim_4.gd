extends CharacterBody2D
class_name inim_4

@onready var sprite = $Sprite
var velocidade = randi_range(10,20)
var vida = randi_range(20,100)
var dano = randi_range(1,9)
var alter_all : Dictionary = {0:"res://sprites/Personagens/inim_4.png",1:"res://sprites/Personagens/inv player.png"}
var alter_all_int := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position.x = randi_range(0,96)
	alterar_spt()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(Vector2(48,144))
	if self.global_position.distance_to(Vector2(48,144)) > 5 and vida > 0 and Global.score > 20:
		self.global_position += transform.x * velocidade * delta
	#print(self.global_position )
	if vida <= 0 or Global.reinicio:
		restart()
	if alter_all_int != Global.alterar_sprites:
		alterar_spt()
	pass

func restart():
	if vida <= 0 :
		Global.score += 10
	self.global_position = Vector2(randi_range(0,96),-300)
	vida = randi_range(5,25)
	dano = randi_range(20,100)
	velocidade = randi_range(10,20)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		vida -= body.dano
		await get_tree().create_timer(0.1).timeout
		
		

func alterar_spt():
	alter_all_int = Global.alterar_sprites
	sprite.set_texture(load(alter_all[alter_all_int]))
