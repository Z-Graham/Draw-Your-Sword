extends CharacterBody2D


@export var speed := 300
@onready var ui: CanvasLayer = $UI
var health_label
var max_health : int  = Globals.player_stats["max_health"]
var magic_label
var max_magic : int = Globals.player_stats["max_MP"]


var health := max_health:
	set(new_health):
		health = new_health
		health_label.text = "HP: " + str(health) +"/"+ str(max_health)
		Globals.player_stats["current_health"] = health
		
var magic := max_magic:
	set(new_magic):
		magic = new_magic
		magic_label.text = "MP: " + str(magic) +"/"+ str(max_magic)
		Globals.player_stats["current_MP"] = magic

func _ready() -> void:
	health_label = get_tree().get_first_node_in_group("healthlabel")
	health = max_health
	
	magic_label = get_tree().get_first_node_in_group("magiclabel")
	magic = max_magic


func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if !ui.visible:
			ui.visible = true
	
	if Input.is_action_just_pressed("hurt"): # just for testing
		take_damage()
	if Input.is_action_just_pressed("do_magic"):
		do_magic()

func _physics_process(_delta: float) -> void:
	get_input()
	
	if !ui.visible:
		move_and_slide()
		


func take_damage(): # mostly for testing
	if health >= 1:
		health -= 1

func do_magic(): # for test
	if magic >= 1:
		magic -= 1
