extends Area2D
class_name DrawingSpot

@export var solution : String

signal solution_found

func _on_body_entered(_body: Node2D) -> void:
	print("open the notebook")
	solution_found.emit()
	#open_notebook()
