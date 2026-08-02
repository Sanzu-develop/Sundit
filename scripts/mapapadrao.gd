extends Node2D

@onready var mun = $Mun
@onready var vid = $Vida
@onready var score = $score
@onready var max_score = $max_score
@onready var player = $Player
var ok = true
var ok2 = false
#var timer = 0
const BULLET = preload("res://scenes/player/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mun.text = str(Global.municao)
	vid.text = str(Global.vida)
	score.text = str(Global.score)
	max_score.text = str(Global.max_score)
	#timer += delta
	#print(timer)
	
	if get_viewport().get_mouse_position().y > 144:
		#await get_tree().create_timer(0.5).timeout
		#atirar()
		pass
	
	#if Global.max_score < Global.score and Global.inicio and Global.vida <= 0:
		#Global.max_score = Global.score
		#Global.save_file(Global.max_score)
		#Global.max_score = Global.load_file()

func atirar() -> void:
	if ok:
		ok = false
		var bullet = BULLET.instantiate()
		bullet.apontar(Vector2(randi_range(Global.apontar.x-Global.arma_p[5],Global.apontar.x+Global.arma_p[5]),Global.apontar.y),randi_range(Global.arma_p[0],Global.arma_p[1]),player.get_bullet_pos())
	#bullet_.posplayer(Vector2(48,144))
		if Global.municao > 0:
			add_child(bullet)
			if Global.arma_p == Global.doze:
				bullet = BULLET.instantiate()
				bullet.apontar(Vector2(randi_range(Global.apontar.x-Global.arma_p[5],Global.apontar.x+Global.arma_p[5]),Global.apontar.y),randi_range(Global.arma_p[0],Global.arma_p[1]),player.get_bullet_pos())
				add_child(bullet)
			Global.municao -= 1
		await get_tree().create_timer(Global.arma_p[2]).timeout
		ok = true
	

func _on_atirar_button_down() -> void:
	ok2 = true
	while ok2:
		atirar()
		await get_tree().create_timer(0.1).timeout
		

func _on_atirar_button_up() -> void:
	ok2 = false
