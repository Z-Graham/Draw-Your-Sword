extends Area2D




func _on_body_entered(_body: Node2D) -> void:
	print("start battle")

	get_tree().call_deferred("change_scene_to_file", "battle_screen.tscn")
