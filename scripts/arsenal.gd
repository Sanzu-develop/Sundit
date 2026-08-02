extends Node2D

@onready var node = $Node
@onready var dano = $Node/Dano
@onready var disp_p_s = $Node/Disp_p_s
@onready var mun = $Node/Mun
@onready var rec = $Node/Recarga
@onready var esp = $Node/Espalhar
@onready var des = $Node/Desbloquear
@onready var sprite = $arma
var arms : Dictionary = {
	0:{
	"dan": "Dano : 1 a 4",
	"disp": "Disp/seg : 10",
	"mun":"Munição : 30",
	"rec":"Recarga : 2.5s",
	"esp":"Espalhar : 10",
	"spr":"res://sprites/Objetos/Metralhadora.png",
	"estr":0,
	"des":"Desbloquear : 0"
},
	1:{
	"dan": "Dano : 2 a 3",
	"disp": "Disp/seg : 5",
	"mun":"Munição : 50",
	"rec":"Recarga : 1.5s",
	"esp":"Espalhar : 2",
	"spr":"res://sprites/Objetos/Pistola.png",
	"estr":20,
		"des":"Desbloquear : 20"
},
	2:{
	"dan": "Dano : 9 a 15",
	"disp": "Disp/seg : 2",
	"mun":"Munição : 8",
	"rec":"Recarga : 3.0s",
	"esp":"Espalhar : 15",
	"spr":"res://sprites/Objetos/doze.png",
	"estr":50,
		"des":"Desbloquear : 50"
}
}
var arm_at := Global.arm_p

func _ready() -> void:
	#if Global.arma_p != Global.arms[arm_at]:
		#while Global.arma_p == Global.arms[arm_at]:
			#arm_at += 1
	#await get_tree().create_timer(0.5).timeout
	arr_label()


func _on_dir_pressed() -> void:
	if arm_at <= Global.arms.size() - 2 :
		arm_at += 1
	else:
		arm_at = 0
	arr_label()

func _on_esq_pressed() -> void:
	if arm_at >= 1 :
		arm_at -= 1
	else:
		arm_at = Global.arms.size() - 1
	arr_label()

func arr_label():
	dano.text = arms[arm_at]["dan"]
	disp_p_s.text = arms[arm_at]["disp"]
	mun.text = arms[arm_at]["mun"]
	rec.text = arms[arm_at]["rec"]
	esp.text = arms[arm_at]["esp"]
	des.text = arms[arm_at]["des"]
	sprite.set_texture(load(arms[arm_at]["spr"]))
	if arms[arm_at]["estr"] > Global.max_score:
		sprite.modulate = Color(0.498, 0.498, 0)
	elif arms[arm_at]["estr"] <= Global.max_score:
		Global.arma_p = Global.arms[arm_at]
		Global.arm_p = arm_at
		sprite.modulate = Color(1, 1, 1)
		
		


func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes/mapapadrao.tscn")
