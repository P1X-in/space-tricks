extends Node2D

@export var gold_outcome: Dictionary = {
	"gold": -1,
	"happiness": 1,
	"boredom": 1
}
@export var kill_outcome: Dictionary = {
	"gold": 1,
	"happiness": -1,
	"boredom": -1
}
@export var messages: Array = [
	"Hold my beer!",
	"But we don't know any tricks!"
]

func get_random_message() -> String:
	return self.messages[randi_range(0, self.messages.size() - 1)]
	
func trick() -> void:
	$"animations".play("trick")
	
func reset_state() -> void:
	$"animations".play("RESET")
