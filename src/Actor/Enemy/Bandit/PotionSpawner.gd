extends Position2D

var health_potion = preload("res://src/Potion/HealthPotion.tscn")
var mana_potion = preload("res://src/Potion/ManaPotion.tscn")

func spawn():
	randomize()
	var potion = [health_potion, mana_potion, null]
	var rand_potion = potion[randi() % potion.size()]
	
	if rand_potion != null:
		var new_potion = rand_potion.instance()
		new_potion.global_position = self.global_position
		owner.get_parent().get_parent().add_child(new_potion)
