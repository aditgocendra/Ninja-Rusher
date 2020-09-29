extends RigidBody2D

func _on_ManaPotion_body_entered(body):
	if body.name == "Player":
		if Autoload.max_mana < 100:
			Autoload.max_mana += 10
			if Autoload.max_mana > 100:
				Autoload.max_mana = 100
			queue_free()
