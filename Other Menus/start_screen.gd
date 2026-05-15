extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("appear")




func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://rooms/over_world.tscn")





func _on_quit_pressed() -> void:
	get_tree().quit()
