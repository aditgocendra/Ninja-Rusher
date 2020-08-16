extends Area2D

onready var damage_player = 10

func _on_SwingSpike_body_entered(body):
	if body is Player:
		var direct_player = 1 if body.velocity.x < 0 else -1 
		body._die(direct_player, damage_player)
