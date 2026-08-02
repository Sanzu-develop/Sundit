extends CharacterBody2D
class_name inim_2

@onready var sprite = $Sprite
var velocidade = randi_range(40,120)
var vida = randi_range(5,10)
var dano = randi_range(1,5)
var cor = Color(0, 1, 0.055) 
var alter_all : Dictionary = {0:"res://sprites/Personagens/inim_4.png",1:"res://sprites/Personagens/inv player.png"}
var alter_all_int := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position.x = randi_range(0,96)
	alterar_spt()
	cor = Color(float(randi_range(111,999))/1000,float(randi_range(111,999))/1000,float(randi_range(111,999))/1000)
	sprite.modulate = cor 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(Vector2(48,144))
	if self.global_position.distance_to(Vector2(48,144)) > 5 and vida > 0:
		self.global_position += transform.x * velocidade * delta
	#print(self.global_position )
	if vida <= 0 or Global.reinicio:
		restart()
	if alter_all_int != Global.alterar_sprites:
		alterar_spt()
	pass

func restart():
	if vida <= 0 :
		Global.score += 1
		cor = Color(float(randi_range(111,999))/1000,float(randi_range(111,999))/1000,float(randi_range(111,999))/1000)
		sprite.modulate = cor 
	self.global_position = Vector2(randi_range(0,96),-300)
	vida = randi_range(5,10)
	dano = randi_range(1,5)
	velocidade = randi_range(40,120)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		vida -= body.dano
		sprite.modulate = Color(1.0,1.0,1.0)
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = cor
		
		
		
func alterar_spt():
	alter_all_int = Global.alterar_sprites
	sprite.set_texture(load(alter_all[alter_all_int]))
		
