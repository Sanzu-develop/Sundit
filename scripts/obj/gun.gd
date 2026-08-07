extends Node2D
class_name Gun

@export var sound_parent : Node2D


func eject():
	var sounds = sound_parent.get_children()
	var sound_force = true
	for sound in sounds:
		if sound is AudioStreamPlayer2D:
			if not sound.playing:
				sound.play()
				sound_force = false
	if sound_force: sounds[0].play()
	
