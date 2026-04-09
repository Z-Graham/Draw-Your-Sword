extends Control

@export var c_room=""



func _on_continue_pressed() -> void:
	var bs=get_tree().get_first_node_in_group("BattleScreenLayer")
	bs.visible=false
	visible=false
