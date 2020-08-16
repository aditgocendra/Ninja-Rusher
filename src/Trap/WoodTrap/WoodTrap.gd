extends Area2D

onready var damage_player = 5


func _ready():
	$AnimationPlayer.play("play_trap")
	

func _on_WoodTrap_body_entered(body):
	if body is Player:
		body._die(0, damage_player)
