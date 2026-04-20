extends Area2D
class_name DrawingSpot

@export var draw_item_screen : Control

signal opened

func _on_body_entered(_body: Node2D) -> void:
	print("open the notebook")
	opened.emit()
	draw_item_screen.visible = true
	queue_free()
	#open_notebook()
