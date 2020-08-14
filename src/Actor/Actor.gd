extends KinematicBody2D
class_name Actor


const FLOOR_NORMAL = Vector2.UP

onready var gravity = 1100.0
var velocity = Vector2.ZERO

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
func _physics_process(delta):
	velocity.y += gravity * delta
	


