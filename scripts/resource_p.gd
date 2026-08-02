extends Resource
class_name padrao_r

@export var municao = 0
@export var vida = 10
@export var score = 0
@export var max_score = int("res://pontuacao/pontua.txt") 

const Path := "res://pontuacao/pontua.txt"

func save_file(save):
	var file = FileAccess.open(Path,FileAccess.WRITE)
	file.store_string(str(save))
	pass
	
func load_file():
	var file = FileAccess.open(Path,FileAccess.READ)
	max_score = int(file.get_as_text())
	return max_score

func botoes(number: int):
	if number == 1:
		pass
	pass
