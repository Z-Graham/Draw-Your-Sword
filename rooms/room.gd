extends Node2D

@export var next_room = ""
@export var previous_room = ""

func _on_leave_room_detector_body_entered(_body: Node2D) -> void:
	print("move to next room")
	get_tree().call_deferred("change_scene_to_file",next_room)
