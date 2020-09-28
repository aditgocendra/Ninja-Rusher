extends Node2D

onready var enemy = preload("res://src/Actor/Enemy/Bandit/Bandit.tscn")

var x_random
var y_random

onready var spawn_timer = $SpawnTimer


func _ready():
	spawn_timer.start()

func _spawn():
	var enemy_isntance = enemy.instance() 
	x_random = rand_range(70, 1550)
	y_random = rand_range(-256, 400)
	enemy_isntance.global_position = Vector2(x_random, y_random)
	enemy_isntance.set_as_toplevel(true)
	add_child(enemy_isntance)
	spawn_timer.start()




func _on_SpawnTimer_timeout():
	_spawn()
