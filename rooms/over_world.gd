extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var battle_screen: Node2D = $BattleScreenLayer/Battle_screen


func _on_room_left(_room : Room, next : bool, down : bool) -> void:
	print("room left emitted")
	if next:
		if _room.next_room != null:
			camera_2d.global_position = _room.next_room.global_position
			player.global_position = _room.next_room.enter_spawn_point.global_position
	else:
		if down:
			camera_2d.global_position = _room.down_room.global_position
			player.global_position = _room.down_room.enter_spawn_point.global_position
		
		elif _room.previous_room != null:
			camera_2d.global_position = _room.previous_room.global_position
			player.global_position = _room.previous_room.return_spawn_point.global_position
		
		elif _room.up_room != null:
			camera_2d.global_position = _room.up_room.global_position
			player.global_position = _room.up_room.up_return_spawn_point.global_position
			
	#move camera and player
	


func _on_room_item_drawing_started() -> void:
	player.speed = 0


func _on_room_draw_spot_solution_found() -> void:
	player.speed = 300
