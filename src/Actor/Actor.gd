extends KinematicBody2D
class_name Actor


const FLOOR_NORMAL = Vector2.UP

onready var gravity = 1100.0
var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity.y += gravity * delta
	
	


