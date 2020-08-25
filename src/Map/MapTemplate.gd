extends Node2D

onready var fps_label = $LayerFPS/Label

	
func _process(_delta):
	fps_label.text = str(Engine.get_frames_per_second()) + "FPS"



