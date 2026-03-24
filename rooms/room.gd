extends Node2D


func _on_leave_room_detector_body_entered(_body: Node2D) -> void:
	print("move to next room")
	# change_scene()?
