extends Area2D

@export_enum("regular", "other") var type := "regular"


func _on_body_entered(_body: Node2D) -> void:
	print("start battle")

	var battle_screen_layer := get_tree().get_first_node_in_group("BattleScreenLayer")
	battle_screen_layer.visible = true
	var battle_screen=get_tree().get_first_node_in_group("BattleScreenLayer").get_child(0)
	battle_screen.reset()
	queue_free()
