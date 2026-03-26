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


var player_health=100
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
	health_bar.max_value=Globals.player_max_health
	health_bar.value=Globals.player_max_health-Globals.player_current_health
	health_label.text="Health: "+str(Globals.player_current_health)+"/"+str(Globals.player_max_health)

func player_fight(blade:String,handle:String,imbue:String):
	pass


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
		if Globals.player_current_health<Globals.player_max_health-30:
			Globals.player_current_health+=30
		else:
			Globals.player_current_health=Globals.player_max_health
