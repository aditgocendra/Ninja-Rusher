extends Node

onready var camera_player = $Player/Camera2D
onready var player = $Player
onready var level_succsess_scene = preload("res://src/UserInterface/LevelSucsess/LevelSucsess.tscn").instance()


func _ready():
	setup_level()

func _process(_delta):
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
	
	
