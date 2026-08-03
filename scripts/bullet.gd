extends CharacterBody2D
class_name Bullet

var velocidade = 300
var apont = Global.apontar
var dano 
var used : bool = false
var vida = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func eject(direction: Vector2):
	var tween = create_tween()
	tween.tween_property(self,"global_position",direction,1.0)
	
	await tween.finished
	
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#look_at(apont)
	#if self.global_position.distance_to(apont) > 5:
		#velocity = position.direction_to(apont) * velocidade
	##print(self.global_position )
		#move_and_slide()
	#else :
		#queue_free()
	#pass

func apontar(ap: Vector2,dan: int,pos: Vector2):
	if used == false:
		self.global_position = pos
		apont = ap
		dano = dan
		used = true
		print(dano)

func posplayer(pos: Vector2):
	self.global_position = pos
	return pos
