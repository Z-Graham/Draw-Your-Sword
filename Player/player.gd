extends CharacterBody2D


@export var speed := 300
@onready var ui: CanvasLayer = $UI
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var health_label
var max_health : int  = Globals.player_stats["max_health"]
var magic_label
var max_magic : int = Globals.player_stats["max_MP"]
var blade_label
var handle_label
var imbue_label
var key_label

#var screen_size

#var health := max_health:
	#set(new_health):
		##health = new_health
		#health_label.text = "HP: " + str(Globals.player_stats["current_health"]) +"/"+ str(max_health)
		#Globals.player_stats["current_health"] = new_health
		#health = new_health
		
#var magic := max_magic:
	#set(new_magic):
		##magic = new_magic
		#magic_label.text = "MP: " + str(Globals.player_stats["current_MP"]) +"/"+ str(max_magic)
		#Globals.player_stats["current_MP"] = new_magic
		#magic = new_magic

func _ready() -> void:
	health_label = get_tree().get_first_node_in_group("healthlabel")
	Globals.player_stats["current_health"] = max_health
	health_label.text = "HP: " + str(Globals.player_stats["current_health"]) +"/"+ str(max_health)
	
	magic_label = get_tree().get_first_node_in_group("magiclabel")
	Globals.player_stats["current_MP"] = max_magic
	magic_label.text = "MP: " + str(Globals.player_stats["current_MP"]) +"/"+ str(max_magic)
	
	blade_label = get_tree().get_first_node_in_group("BladeLabel")
	handle_label = get_tree().get_first_node_in_group("handleLabel")
	imbue_label = get_tree().get_first_node_in_group("ImbueLabel")
	key_label = get_tree().get_first_node_in_group("KeyLabel")
	
	#screen_size = get_viewport_rect().size

func get_input():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	if input_dir==Vector2(1.0,0.0):
		sprite_2d.play("walk side")
		sprite_2d.flip_h=false
	elif input_dir==Vector2(-1.0,0.0):
		sprite_2d.play("walk side")
		sprite_2d.flip_h=true
	elif input_dir==Vector2(0.0,1.0):
		sprite_2d.play("walk down")
	elif input_dir==Vector2(0.0,-1.0):
		sprite_2d.play("walk up")
	elif input_dir.x<0 and input_dir.x>-1:
		sprite_2d.flip_h=true
		if input_dir.y>0:
			sprite_2d.play("walk down side")
		else:
			sprite_2d.play("walk up side")
	elif input_dir.x>0 and input_dir.x<1:
		sprite_2d.flip_h=false
		if input_dir.y>0:
			sprite_2d.play("walk down side")
		else:
			sprite_2d.play("walk up side")
	else:
		sprite_2d.play("idle")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		health_label.text = "HP: " + str(Globals.player_stats["current_health"]) +"/"+ str(Globals.player_stats["max_health"])
		magic_label.text = "MP: " + str(Globals.player_stats["current_MP"]) +"/"+ str(Globals.player_stats["max_MP"])
		blade_label.text = "BLADE: " + str(Globals.sword["blade"])
		handle_label.text = "HANDLE: " + str(Globals.sword["handle"])
		imbue_label.text = "IMBUE: " + str(Globals.sword["imbue"])
		key_label.text = "KEY: " + str(Globals.keys)
		if !ui.visible:
			ui.visible = true
		else:
			ui.visible = false
	
	if Input.is_action_just_pressed("hurt"): # just for testing
		take_damage()
	if Input.is_action_just_pressed("do_magic"):
		do_magic()

func _physics_process(_delta: float) -> void:
	get_input()
	
	if !ui.visible:
		move_and_slide()
		
	#position = position.clamp(Vector2.ZERO, screen_size)

func take_damage(): # mostly for testing
	Globals.player_stats["current_health"] -= 1
	health_label.text = "HP: " + str(Globals.player_stats["current_health"]) +"/"+ str(Globals.player_stats["max_health"])

func do_magic(): # for test
	Globals.player_stats["current_MP"] -= 1
	magic_label.text = "MP: " + str(Globals.player_stats["current_MP"]) +"/"+ str(Globals.player_stats["max_MP"])
