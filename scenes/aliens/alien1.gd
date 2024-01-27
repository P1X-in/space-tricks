extends Node2D

@onready var animations: AnimationPlayer = $"AnimationPlayer"
@export var bob: bool = false
@export var flip: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.bob:
		self.random_bob()
	if self.flip:
		$"Sprite2D".flip_h = true


func random_bob() -> void:
	self.animations.play("bob")
	self.animations.seek(randf())
