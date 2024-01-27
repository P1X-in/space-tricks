extends Control

@onready var board: Control = $"board"
@onready var game_end: Control = $"end"
@onready var resources: Dictionary = {
	"gold": $"board/resources/gold",
	"happiness": $"board/resources/happiness",
	"boredom": $"board/resources/boredom"
}
@onready var trick_anchor: MarginContainer = $"board/trick"
@onready var message: Label = $"board/message/text"
@onready var score_label: Label = $"board/score/label"
@onready var end_score_label: Label = $"end/score/label"

var tricks: Tricks = preload("res://scenes/tricks/tricks.gd").new()

var current_trick: Node2D = null
var previous_trick: Node2D = null
var current_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.present_next_trick()

	for resource: Node2D in self.resources.values():
		resource.zero_reached.connect(self._game_over)
		resource.max_reached.connect(self._game_over)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self._quit_game()
	if event is InputEventKey and event.keycode == KEY_F:
		self.get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN


func present_next_trick() -> void:
	if self.current_trick != null:
		self.current_trick.reset_state()
		self.trick_anchor.remove_child(self.current_trick)
		self.current_trick.show()
		self.previous_trick = self.current_trick
	while self.current_trick == self.previous_trick:
		self.current_trick = self.tricks.get_random_trick()
	self.trick_anchor.add_child(self.current_trick)
	self.current_trick.trick()

	self.message.set_text(self.current_trick.get_random_message())


func _on_kill_mouse_entered() -> void:
	self._show_resource_change(self.current_trick.kill_outcome)


func _on_gold_mouse_entered() -> void:
	self._show_resource_change(self.current_trick.gold_outcome)


func _on_kill_pressed() -> void:
	self._apply_resource_change(self.current_trick.kill_outcome)
	self._increase_score()
	$"board/animations".play("explode")


func _on_gold_pressed() -> void:
	self._apply_resource_change(self.current_trick.gold_outcome)
	self._increase_score()
	$"board/animations".play("poo")


func _on_mouse_exited() -> void:
	for resource: Node2D in self.resources.values():
		resource.clear_hint()


func _show_resource_change(change: Dictionary) -> void:
	for resource_key: String in change:
		self.resources[resource_key].show_hint(change[resource_key])


func _apply_resource_change(change: Dictionary) -> void:
	for resource_key: String in change:
		self.resources[resource_key].change_resource(change[resource_key])


func _turn_progress(change: Dictionary) -> void:
	self._apply_resource_change(change)
	self._increase_score()
	self.present_next_trick()


func _set_score_label(new_score: int) -> void:
	self.score_label.set_text("Wynik: " + str(new_score))
	self.end_score_label.set_text("GAME OVER\nWYNIK: " + str(new_score))


func _increase_score() -> void:
	self.current_score += 1
	self._set_score_label(self.current_score)


func _game_over() -> void:
	if self.game_end.is_visible():
		return
	self.board.hide()
	self.game_end.show()


func _try_again_pressed() -> void:
	self.current_score = 0
	self._set_score_label(0)
	for resource: Node2D in self.resources.values():
		resource.reset_value()
	self.game_end.hide()
	self.board.show()
	self.present_next_trick()


func _quit_game() -> void:
	self.get_tree().quit()


func _hide_trick() -> void:
	self.current_trick.hide()
