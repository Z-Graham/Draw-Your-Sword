extends Node2D

@export var next_room = ""
@export var previous_room = ""

@onready var healing_label: Label = $HealingLabel
@onready var magic_label: Label = $MagicLabel

func _ready() -> void:
	var items = get_tree().get_nodes_in_group("collectedItems")
	for i in items:
		i.queue_free()

func _on_leave_room_detector_body_entered(_body: Node2D) -> void:
	print("move to next room")
	get_tree().call_deferred("change_scene_to_file",next_room)


func _on_item_picked_up(_item : Area2D) -> void:
	var type = _item.type
	if type == "healing":
		healing_label.visible = true
		await get_tree().create_timer(1.5).timeout
		healing_label.visible = false
		Globals.healing_items["HP Potion"] += 1
		
	elif type == "magic":
		magic_label.visible = true
		await get_tree().create_timer(1.5).timeout
		magic_label.visible = false
		Globals.healing_items["MP Potion"] += 1
	
