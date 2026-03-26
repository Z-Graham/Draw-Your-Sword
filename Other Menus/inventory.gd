extends Control
@onready var battle_item_list: ItemList = $BattleItemList
@onready var healing_item_list: ItemList = $HealingItemList
@onready var key_item_list: ItemList = $KeyItemList
@onready var description: Label = $"description box/description"

signal item_used(String)

var sel_item:String
var sel_item_index:int
var current_screen:ItemList

var in_battle=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_screen=healing_item_list
	sel_item="em"
	sel_item_index=-1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	




func _on_x_button_pressed() -> void:
	visible=false


func _on_heal_tab_pressed() -> void:
	healing_item_list.visible=true
	battle_item_list.visible=false
	key_item_list.visible=false
	current_screen=healing_item_list


func _on_battle_tab_pressed() -> void:
	healing_item_list.visible=false
	battle_item_list.visible=true
	key_item_list.visible=false
	current_screen=battle_item_list


func _on_key_tab_pressed() -> void:
	healing_item_list.visible=false
	battle_item_list.visible=false
	key_item_list.visible=true
	current_screen=key_item_list


func _on_healing_item_list_item_selected(index: int) -> void:
	sel_item=healing_item_list.get_item_text(index)
	sel_item_index=index
	if sel_item=="HP Potion":
		description.text="A simple healing potion.
		Heals 30 HP"
	if sel_item=="MP Potion":
		description.text="A simple mana potion.
		Restores 30 MP"


func _on_use_button_pressed() -> void:
	if not sel_item=="em":
		current_screen.remove_item(sel_item_index)
	if sel_item=="HP Potion":
		item_used.emit("HP Potion")
	elif sel_item=="MP Potion":
		item_used.emit("MP Potion")
	description.text=""
	sel_item="em"
	sel_item_index=-1
	visible=false
