extends Area2D



func _on_ManaPotion_body_entered(body):
	if body is Player:
		if Autoload.max_mana < 100:
			Autoload.max_mana += 10
			queue_free()
