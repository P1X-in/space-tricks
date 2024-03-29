class_name Tricks

var tricks: Array = [
	preload("res://scenes/tricks/tower.tscn").instantiate(),
	preload("res://scenes/tricks/bahleda.tscn").instantiate(),
	preload("res://scenes/tricks/helicopter.tscn").instantiate(),
	preload("res://scenes/tricks/loki.tscn").instantiate(),
	preload("res://scenes/tricks/poo.tscn").instantiate(),
	preload("res://scenes/tricks/hipnoza.tscn").instantiate(),
	preload("res://scenes/tricks/techno.tscn").instantiate(),
	preload("res://scenes/tricks/spear.tscn").instantiate(),
	preload("res://scenes/tricks/pizza.tscn").instantiate(),
	preload("res://scenes/tricks/tennis.tscn").instantiate(),
	preload("res://scenes/tricks/juggle.tscn").instantiate()
]

func get_random_trick() -> Node2D:
	return self.tricks[randi_range(0, self.tricks.size() - 1)]
