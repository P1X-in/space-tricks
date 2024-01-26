extends Node2D

signal zero_reached
signal max_reached

@onready var bar: ColorRect = $"fill"
@onready var chevrons: Dictionary = {
	"up": {
		0: $"chevrons/chevron_up0",
		1: $"chevrons/chevron_up1",
		2: $"chevrons/chevron_up2"
	},
	"down": {
		0: $"chevrons/chevron_down0",
		1: $"chevrons/chevron_down1",
		2: $"chevrons/chevron_down2"
	}
}


@export var starting_value: int = 15
@export var max_value: int = 30
@export var step: int = 5
var current_value: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.current_value = self.starting_value


func reset_value() -> void:
	self.current_value = self.starting_value
	self.set_progress(self.current_value)
	self.clear_hint()


func set_progress(value: int) -> void:
	var normalised_value: int = clampi(value, 0, self.max_value)
	self.bar.size.y = self.step * normalised_value


func add_resource(value: int=1) -> void:
	self.current_value += value
	if self.current_value >= self.max_value:
		self.current_value = self.max_value
	self.set_progress(self.current_value)
	if self.current_value == self.max_value:
		self.max_reached.emit()


func remove_resource(value: int=1) -> void:
	self.current_value += value
	if self.current_value <= 0:
		self.current_value = 0
	self.set_progress(self.current_value)
	if self.current_value == 0:
		self.zero_reached.emit()


func change_resource(value: int) -> void:
	if value < 0:
		self.remove_resource(value)
	if value > 0:
		self.add_resource(value)

func show_hint(value: int) -> void:
	if value <= -3:
		self.chevrons["down"][2].show()
	if value <= -2:
		self.chevrons["down"][1].show()
	if value <= -1:
		self.chevrons["down"][0].show()

	if value >= 1:
		self.chevrons["up"][0].show()
	if value >= 2:
		self.chevrons["up"][1].show()
	if value >= 3:
		self.chevrons["up"][2].show()


func clear_hint() -> void:
	for direction: Dictionary in self.chevrons.values():
		for chevron: Sprite2D in direction.values():
			chevron.hide()
