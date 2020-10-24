extends Node

onready var camera_player = $Player/Camera2D
onready var player = $Player
onready var level_succsess_scene = preload("res://src/UserInterface/LevelSucsess/LevelSucsess.tscn").instance()
var show_fps
onready var fps_label = $LayerFPS/Label

func _ready():
	setup_level()
	var data = Autoload.json_data
	show_fps = data["game_settings"]["fps"]["show_fps"]
	

func _process(_delta):
	if show_fps:
		fps_label.text = str(Engine.get_frames_per_second()) + "FPS"
		
	if player.global_position.x >= camera_player.limit_right:
		$LayerLevelSuccsess.add_child(level_succsess_scene)
		get_tree().paused = true

func setup_level():
	var level = self.name
	var data_level =  Autoload.load_data()
	var limit_camera_level =  data_level["adventure_mode"][level]["limit_camera"]
	
	camera_player.limit_left = limit_camera_level["left"]
	camera_player.limit_right = limit_camera_level["right"]
	camera_player.limit_bottom = limit_camera_level["bottom"]
	camera_player.limit_top = limit_camera_level["top"]
	
	
