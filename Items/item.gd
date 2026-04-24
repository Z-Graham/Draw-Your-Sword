extends Area2D
#class_name Item

@export_enum("healing","magic") var type : String = "healing"

var collected = false

signal picked_up

func _ready() -> void:
	if type == "healing":
		modulate = "green"
	elif type == "magic":
		modulate = "purple"


func _on_body_entered(_body: Node2D) -> void:
	picked_up.emit(self)
	collected = true
	queue_free()
