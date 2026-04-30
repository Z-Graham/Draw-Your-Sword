extends Area2D

@export_enum("blade","handle","imbue") var type:String
@export var item_name:String
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

signal collected()
var collect=false

func _on_body_entered(body: Node2D) -> void:
	collected.emit(self)
	if collect==false:
		sprite_2d.play("open")
		collect=true
		await get_tree().create_timer(1).timeout
		queue_free()
