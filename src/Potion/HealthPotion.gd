extends RigidBody2D



func _on_HealthPotion_body_entered(body):
	if body is Player:
		if Autoload.max_health < 100:
			Autoload.max_health += 10
			if Autoload.max_health > 100:
				Autoload.max_health = 100
			queue_free()
