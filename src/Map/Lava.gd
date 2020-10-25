extends Area2D



func _on_Lava_body_entered(body):
	if body is Player:
		Autoload.max_health = 0
