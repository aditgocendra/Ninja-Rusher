extends Node2D

onready var fps_label = $LayerFPS/Label
var show_fps

func _ready():
	var data = Autoload.json_data
	show_fps = data["game_settings"]["fps"]["show_fps"]
	
	
func _process(_delta):
	if show_fps:
		fps_label.text = str(Engine.get_frames_per_second()) + "FPS"



