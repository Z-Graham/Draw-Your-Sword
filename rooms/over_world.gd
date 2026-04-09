extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player


func _on_room_left(_room : Room, next : bool) -> void:
	print("do something")
	if next:
		camera_2d.global_position = _room.next_room.global_position
		player.global_position = _room.next_room.enter_spawn_point.global_position
	else:
		camera_2d.global_position = _room.previous_room.global_position
		player.global_position = _room.previous_room.return_spawn_point.global_position
	#move camera and player
	
