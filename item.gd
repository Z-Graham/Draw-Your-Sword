extends Area2D
#class_name Item

@export_enum("healing","magic") var type : String = "healing"

var collected = false

signal picked_up

func _ready() -> void:
	if type == "healing":
		modulate = "green"
	else:
		modulate = "purple"


func _on_body_entered(_body: Node2D) -> void:
	print("picked up " + type + " item")
	picked_up.emit(self)
	collected = true
	remove_from_group("Items")
	add_to_group("collectedItems")
	queue_free()
