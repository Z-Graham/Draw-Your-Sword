extends Area2D

@export_enum("goblin", "other") var type := "goblin"
@export var has_key := false

@onready var key: Sprite2D = $Key


func _ready() -> void:
	if has_key:
		key.visible = true

func _on_body_entered(_body: Node2D) -> void:
	print("start battle")

	var battle_screen_layer := get_tree().get_first_node_in_group("BattleScreenLayer")
	battle_screen_layer.visible = true
	var battle_screen=get_tree().get_first_node_in_group("BattleScreenLayer").get_child(0)
	battle_screen.reset()
	if has_key:
		Globals.key = true
	queue_free()
