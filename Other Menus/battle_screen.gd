extends Node2D
@onready var inventory: Control = $Inventory
@onready var main_battle_menu: Control = $Main_battle_menu
@onready var fight_battle_menu: Control = $fight_battle_menu
@onready var mp_bar: TextureProgressBar = $"MP bar"
@onready var health_bar: TextureProgressBar = $"health bar"
@onready var player_battle: AnimatedSprite2D = $player_battle
@onready var enemy_battle: AnimatedSprite2D = $enemy_battle
@onready var description: Label = $fight_battle_menu/Panel/Description
@onready var health_label: Label = $"health bar/Health Label"
@onready var mp_label: Label = $"MP bar/MP Label"
@onready var draw_screen: TextureRect = $DrawScreen
@onready var win_screen: ColorRect = $"Win Screen"


var enemy_health=100
var blade="normal"
var handle="normal"
var imbue="none"
var draw_charge:int

var in_main=true
var in_battle=false
var in_inventory=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_charge=5


func _process(delta:float)-> void:
	health_bar.max_value=Globals.player_stats["max_health"]
	health_bar.value=Globals.player_stats["max_health"]-Globals.player_stats["current_health"]
	health_label.text="Health: "+str(Globals.player_stats["current_health"])+"/"+str(Globals.player_stats["max_health"])
	mp_bar.max_value=Globals.player_stats["max_MP"]
	mp_bar.value=Globals.player_stats["max_MP"]-Globals.player_stats["current_MP"]
	mp_label.text="MP: "+str(Globals.player_stats["current_MP"])+"/"+str(Globals.player_stats["max_MP"])

		
	if Input.is_action_just_pressed("do_magic"):
		Globals.player_stats["current_MP"] -= 1
	if Input.is_action_just_pressed("hurt"):
		Globals.player_stats["current_health"] -= 1


func battle_end():
	win_screen.c_room="res://rooms/over_world.tscn"
	$ColorRect2.visible=true
	win_screen.visible=true

func player_fight(blade:String,handle:String,imbue:String):
	fight_battle_menu.visible=false
	health_bar.visible=false
	mp_bar.visible=false
	var damage=50
	var player_move=create_tween()
	player_move.tween_property(player_battle,"global_position",
	Vector2(player_battle.global_position.x+800,
	player_battle.global_position.y),
	1.5)
	
	await player_move.finished
	$damage_label.text=str(damage)
	$damage_label.visible=true
	enemy_health-=damage
	var player_move_back=create_tween()
	player_move_back.tween_property(player_battle,"global_position",
	Vector2(player_battle.global_position.x-800,
	player_battle.global_position.y),
	1.5)
	await player_move_back.finished
	if enemy_health<=0:
		battle_end()
	else:
		fight_battle_menu.visible=true
		health_bar.visible=true
		mp_bar.visible=true
	$damage_label.visible=false
	


func _on_fight_button_pressed() -> void:
	main_battle_menu.visible=false
	fight_battle_menu.visible=true

func _on_item_button_pressed() -> void:
	inventory.visible=true
	inventory.healing_item_list.visible=true
	inventory.battle_item_list.visible=false
	inventory.key_item_list.visible=false
	inventory.current_screen=inventory.healing_item_list


func _on_basic_button_pressed() -> void:
	player_fight(blade,handle,imbue)

func _on_basic_button_mouse_entered() -> void:
	description.text="A basic attack with your weapon.
	Restores 5MP"

func _on_basic_button_mouse_exited() -> void:
	description.text=""

func _on_blade_skill_button_pressed() -> void:
	pass # Replace with function body.

func _on_blade_skill_button_mouse_entered() -> void:
	if blade=="normal":
		description.text="Double Slice: Two rapid attacks with your weapon.
		Costs 20MP"

func _on_blade_skill_button_mouse_exited() -> void:
	description.text=""

func _on_handle_skill_button_pressed() -> void:
	pass # Replace with function body.

func _on_handle_skill_button_mouse_entered() -> void:
	if handle=="normal":
		description.text="Bash: A strike with the pommel of your blade with a chance to confuse the enemy.
		Costs 30MP"

func _on_handle_skill_button_mouse_exited() -> void:
	description.text=""

func _on_back_button_pressed() -> void:
	main_battle_menu.visible=true
	fight_battle_menu.visible=false


func _on_inventory_item_used(item: Variant) -> void:
	if item=="HP Potion":
		if Globals.player_stats["current_health"]<Globals.player_stats["max_health"]-30:
			Globals.player_stats["current_health"]+=30
		else:
			Globals.player_stats["current_health"]=Globals.player_stats["max_health"]
	elif item=="MP Potion":
		if Globals.player_stats["current_MP"]<Globals.player_stats["max_MP"]-20:
			Globals.player_stats["current_MP"]+=20
		else:
			Globals.player_stats["current_MP"]=Globals.player_stats["max_MP"]


func _on_draw_button_pressed() -> void:
	draw_screen.visible = true
