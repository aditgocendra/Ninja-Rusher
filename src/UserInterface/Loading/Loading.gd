extends Node

var scene = "res://src/Map/MapTemplate.tscn"
var queue = preload("res://src/UserInterface/Loading/resource_queue.gd").new()
	
	
	
func _ready():
	queue.start()
	queue.queue_resource(scene, true)
	
	
func _process(_delta):
	if queue.is_ready(scene):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(queue.get_resource(scene))
	
	
	


