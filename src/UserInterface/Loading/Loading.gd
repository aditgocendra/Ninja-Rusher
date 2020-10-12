extends Node

var scene_load
var queue = preload("res://src/UserInterface/Loading/resource_queue.gd").new()


func _ready():
	queue.start()
	scene_load = Autoload.path_load
	
	queue.queue_resource(scene_load, true)
	
	
func _process(_delta):
	if queue.is_ready(scene_load):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(queue.get_resource(scene_load))
	
	
	


