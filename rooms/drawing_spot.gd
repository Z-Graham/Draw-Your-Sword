extends Area2D
class_name DrawingSpot

@export var draw_item_screen : Control
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

signal opened

func _ready() -> void:
	sprite_2d.play("default")

func _on_body_entered(_body: Node2D) -> void:
	opened.emit()
	draw_item_screen.visible = true
	#open_notebook()
