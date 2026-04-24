extends Area2D

@export_enum("blade","handle","imbue") var type:String
@export var item_name:String

signal collected()


func _on_body_entered(body: Node2D) -> void:
	collected.emit(self)
	queue_free()
