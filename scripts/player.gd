extends Node2D
class_name Player

#var player = padrao_r
#var inim1 = inim_1
#@onready var sprite = $Sprite
#@onready var maos = $maos
#@onready var maoe = $maos/maoe
#@onready var maod = $maos/maod
#@onready var maod2 = $maos/maod2
#@onready var arm = $maos/arm
#@onready var bullet_pos = $"maos/bullet position"
@export var target_point : TargetPoint
var look_target_point : bool = false
var body_att = false
var dict_arm_pos : Dictionary = {
	0:{
		"maoe":Vector2(6,0),
		"maod":Vector2(-1,0),
		"armpos":Vector2(2,0),
		"bulpos":Vector2(9,0),
		"arm":"res://sprites/Objetos/mp5 mao.png",
		"armd_select":1
	},
	1:{
		"maoe":Vector2(1,0),
		"maod":Vector2(0,0),
		"armpos":Vector2(2,0),
		"bulpos":Vector2(9,0),
		"arm":"res://sprites/Objetos/pistola mao.png",
		"armd_select":1
	},
	2:{
		"maoe":Vector2(8,0),
		"maod":Vector2(-1,0),
		"armpos":Vector2(4,0),
		"bulpos":Vector2(9,0),
		"arm":"res://sprites/Objetos/doze mao.png",
		"armd_select":2
	}
	}
var alter_all : Dictionary = {
	0:{
		"player":"res://sprites/Personagens/Personagem base.png",
		"maoe":"res://sprites/Personagens/Mao.png",
		"maod":"res://sprites/Personagens/Mao.png"
	},
	1:{
		"player":"res://sprites/Personagens/inv player.png",
		"maoe":"res://sprites/Personagens/inv mao.png",
		"maod":"res://sprites/Personagens/inv mao.png"
	}
	}

var alter_all_int := 0

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	#atu_hands()
	#pass



#
#func _process(delta: float) -> void:
	#look_at(Global.apontar)
	#maos.look_at(Global.apontar)
	#if alter_all_int != Global.alterar_sprites:
		#alter_all_int = Global.alterar_sprites
		#alterar_spt(alter_all_int)
	#pass
	
#Global.vida -= body.dano
#print(body)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("not_player_collide"):
		body_att = true
		while body_att == true and Global.vida > 0:
			Global.vida -= body.dano
			await get_tree().create_timer(1.0).timeout
	print(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	body_att = false

#func get_bullet_pos():
	#return bullet_pos.global_position
#
#func atu_hands():
	#if dict_arm_pos[Global.arm_p]["armd_select"] == 1:
		#maod.visible = true
		#maod2.visible = false
		#maod.position = dict_arm_pos[Global.arm_p]["maod"]
	#elif dict_arm_pos[Global.arm_p]["armd_select"] == 2:
		#maod.visible = false
		#maod2.visible = true
		#maod2.position = dict_arm_pos[Global.arm_p]["maod"]
	#maoe.position = dict_arm_pos[Global.arm_p]["maoe"]
	#arm.position = dict_arm_pos[Global.arm_p]["armpos"]
	#arm.set_texture(load(dict_arm_pos[Global.arm_p]["arm"]))
	#bullet_pos.position = dict_arm_pos[Global.arm_p]["bulpos"]
#
#func alterar_spt(number):
	#sprite.set_texture(load(alter_all[number]["player"]))
	#maoe.set_texture(load(alter_all[number]["maoe"]))
	#maod.set_texture(load(alter_all[number]["maod"]))
	#maod2.set_texture(load(alter_all[number]["maod"]))


func _on_mira_path_initiate() -> void:
	look_target_point = true
	_on_mira_path_runing()

func _on_mira_path_ended() -> void:
	look_target_point = false

func _on_mira_path_runing() -> void:
	if look_target_point:
		look_at(target_point.global_position)
