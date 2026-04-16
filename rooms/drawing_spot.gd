extends Area2D
class_name DrawingSpot

@export var solution : String
@export var draw_item_screen : Control

signal solution_found
signal opened

func _on_body_entered(_body: Node2D) -> void:
	print("open the notebook")
	opened.emit()
	draw_item_screen.visible = true
	solution_found.emit()
	#open_notebook()
