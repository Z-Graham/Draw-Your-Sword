extends Control

@export var c_room=""



func _on_continue_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file",c_room)
