extends Node2D
class_name Room

@export var next_room : Room 
@export var previous_room : Room
@export var num_enemies := 0
@export var num_healing_items := 0
@export var num_magic_items := 0
@export var enter_spawn_point : Marker2D
@export var return_spawn_point: Marker2D

@onready var healing_label: Label = $HealingLabel
@onready var magic_label: Label = $MagicLabel
@onready var leave_room_detector: Area2D = $ColorRect/LeaveRoomDetector
@onready var leave_room_detector_backwards: LeaveRoomDetector = $ColorRect2/LeaveRoomDetectorBackwards

#@onready var enter_spawn_point: Marker2D = $EnterSpawnPoint
#@onready var return_spawn_point: Marker2D = $ReturnSpawnPoint


signal left

func _ready() -> void:
	var items = get_tree().get_nodes_in_group("collectedItems")
	for i in items:
		i.queue_free()

func _on_leave_room_detector_body_entered(_body: Node2D) -> void:
	print("move to next room")
	left.emit(self, leave_room_detector.next)
	#get_tree().call_deferred("change_scene_to_file",next_room)


func _on_leave_room_detector_backwards_body_entered(_body: Node2D) -> void:
	print("move to last room")
	left.emit(self, leave_room_detector_backwards.next)

func _on_item_picked_up(_item : Area2D) -> void:
	var type = _item.type
	if type == "healing":
		Globals.healing_items["HP Potion"] += 1
		healing_label.visible = true
		num_healing_items -= 1
		await get_tree().create_timer(1.5).timeout
		healing_label.visible = false
		
		
		
	elif type == "magic":
		Globals.healing_items["MP Potion"] += 1
		magic_label.visible = true
		num_magic_items -= 1
		await get_tree().create_timer(1.5).timeout
		magic_label.visible = false
	
