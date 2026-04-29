extends Area2D
#class_name Item

@export_enum("healing","magic") var type : String = "healing"
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var collected = false

signal picked_up

func _ready() -> void:
	sprite_2d.play("default")


func _on_body_entered(_body: Node2D) -> void:
	picked_up.emit(self)
	collected = true
	queue_free()
