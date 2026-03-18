extends Area2D

@export_enum("regular", "other") var type := "regular"


func _on_body_entered(_body: Node2D) -> void:
	print("start battle")

	get_tree().call_deferred("change_scene_to_file", "battle_screen.tscn")
