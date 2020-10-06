extends Area2D



func _on_AreaWater_body_entered(body):
	if body is Player:
		Autoload.max_health = 0
