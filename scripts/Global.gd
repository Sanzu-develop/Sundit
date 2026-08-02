extends Node

@export var municao = 0
@export var dano = 0
@export var vida = 0
@export var max_score = -1
@export var score = 0
@export var apontar = Vector2.ZERO
@export var mp5 : Array = [1,4,0.1,30,2.5,10]
@export var pistola : Array = [2,3,0.2,50,1.5,2]
@export var doze : Array = [9,15,0.5,8,3.0,15]
@export var arms : Array = [mp5,pistola,doze]
@export var arm_p : int = 0
@export var arma_p : Array = arms[arm_p]
@export var reinicio : bool = false
@export var recarg_ok : bool = true
@export var trav : bool = true
@export var inicio: bool = false
@export var alterar_sprites := 0
@export var alterar_fundo := 0

const Path := "user://pontua.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_file()
	inicio = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if municao < 1:
		recarga(arma_p[4])
	if max_score < score and inicio == true and vida <= 0 and trav:
		trav = false
		max_score = score
		save_file(max_score)
		max_score = load_file()
	if vida >= 0 and trav == false:
		trav = true
	pass


func save_file(save):
	var file = FileAccess.open(Path,FileAccess.WRITE)
	file.store_string(str(save))
	file.close()
	pass
					
func load_file():
	if FileAccess.file_exists(Path):
		var file = FileAccess.open(Path,FileAccess.READ)
		max_score = int(file.get_as_text())
		file.close()
		return max_score

func botoes(number: int):
	if number == 1:
		reinicio = true
		await get_tree().create_timer(0.1).timeout
		reinicio = false
		if max_score >= 20 and vida <= 0:
			vida = 20
		elif vida <= 0:
			vida = 10
		municao = 0
		score = 0
	elif number == 2:
		get_tree().change_scene_to_file("res://scenes/scenes/arsenal.tscn")
	elif number == 3:
		if alterar_sprites == 0:
			alterar_sprites = 1
		else:
			alterar_sprites = 0
		if alterar_fundo <= 9:
			alterar_fundo += 1
		else:
			alterar_fundo = 0
	pass

func recarga(time: float):
	if recarg_ok:
		recarg_ok = false
		await get_tree().create_timer(time).timeout
		if municao <= 0:
			municao = arma_p[3]
		recarg_ok = true
