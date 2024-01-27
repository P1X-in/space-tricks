class_name Tricks

var tricks: Array = [
	preload("res://scenes/tricks/tower.tscn").instantiate(),
	preload("res://scenes/tricks/bahleda.tscn").instantiate()
]

func get_random_trick() -> Node2D:
	return self.tricks[randi_range(0, self.tricks.size() - 1)]
