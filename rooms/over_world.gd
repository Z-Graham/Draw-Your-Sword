extends Node2D

@onready var camera_2d: Camera2D = $Camera2D


func _on_room_left(_room : Room) -> void:
	print("do something")
	camera_2d.global_position = _room.next_room.global_position
	#move camera
