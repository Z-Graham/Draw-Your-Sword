extends Node2D
class_name Room


# EXPORTED ROOMS
@export var next_room : Room 
@export var previous_room : Room
@export var down_room : Room
@export var up_room : Room

@export var num_enemies := 0
@export var num_healing_items := 0
@export var num_magic_items := 0
@export var enter_spawn_point : Marker2D
@export var return_spawn_point: Marker2D
@export var up_return_spawn_point: Marker2D
@export var trench : Node

@onready var healing_label: Label = $HealingLabel
@onready var magic_label: Label = $MagicLabel
@onready var leave_room_detector: Area2D = $ColorRect/LeaveRoomDetector
@onready var leave_room_detector_backwards: LeaveRoomDetector = $ColorRect2/LeaveRoomDetectorBackwards
@onready var leave_room_detector_down: LeaveRoomDetector = $ColorRect3/LeaveRoomDetectorDown
@onready var leave_room_detector_up: LeaveRoomDetector = $ColorRect4/LeaveRoomDetectorUp


#@onready var enter_spawn_point: Marker2D = $EnterSpawnPoint
#@onready var return_spawn_point: Marker2D = $ReturnSpawnPoint


signal left
signal item_drawing_started
signal draw_spot_solution_found

func _ready() -> void:
	var items = get_tree().get_nodes_in_group("collectedItems")
	for i in items:
		i.queue_free()

func _on_leave_room_detector_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.25).timeout
	print("move to next room")
	left.emit(self, leave_room_detector.next,leave_room_detector.down)


func _on_leave_room_detector_backwards_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.25).timeout
	print("move to last room")
	left.emit(self, leave_room_detector_backwards.next, leave_room_detector_backwards.down)

func _on_item_picked_up(_item : Area2D) -> void:
	var type = _item.type
	if type == "healing":
		if magic_label.visible:
			magic_label.visible = false
		Globals.healing_items["HP Potion"] += 1
		healing_label.visible = true
		num_healing_items -= 1
		await get_tree().create_timer(1.5).timeout
		healing_label.visible = false
		
		
		
	elif type == "magic":
		if healing_label.visible:
			healing_label.visible = false
		Globals.healing_items["MP Potion"] += 1
		#healing_label.text = "Picked up Magic Item"
		magic_label.visible = true
		num_magic_items -= 1
		await get_tree().create_timer(1.5).timeout
		magic_label.visible = false
		#healing_label.text = "Picked up Healing Item"
	


func _on_drawing_spot_opened() -> void:
	item_drawing_started.emit()


func _on_draw_item_screen_solution_gotten(_solution: String) -> void:
	if _solution == "Bridge":
		trench.visible = false
		trench.collision_layer = 1
		draw_spot_solution_found.emit()


func _on_leave_room_detector_down_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.25).timeout
	print("move to down room")
	left.emit(self, leave_room_detector_down.next,leave_room_detector_down.down)




func _on_sword_item_collected(_item:Area2D) -> void:
	print(_item.item_name)
	print(_item.type)
	var type=_item.type
	if type=="blade":
		Globals.known_blades.append(_item.item_name)
		


func _on_leave_room_detector_up_body_entered(_body: Node2D) -> void:
	await get_tree().create_timer(0.25).timeout
	print("move to up room")
	left.emit(self, leave_room_detector_up.next,leave_room_detector_up.down)
