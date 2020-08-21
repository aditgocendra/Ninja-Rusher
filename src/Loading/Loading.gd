extends CanvasLayer

var level_thread = Thread.new()
onready var load_percent = $ColorRect/ProgressBar
onready var next_scene = "res://src/Map/MapTemplate.tscn"

func _ready():
	load_game()


func _process(delta):
	if load_percent.value == load_percent.max_value:
		get_tree().change_scene_to(next_scene)


func load_game():
	load_percent.value += 50
	level_thread.start(self, "InstanceLevel", null, 2)


func InstanceLevel(empty):
	load_percent.value += 50 
	level_thread.wait_to_finish()
	
