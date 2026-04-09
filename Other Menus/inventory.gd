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
	for item in (Globals.healing_items):
		if Globals.healing_items[item]>1:
			healing_item_list.add_item(item+"   x"+str(Globals.healing_items[item]))
		elif Globals.healing_items[item]==1:
			healing_item_list.add_item(item)
		
func update():
	sel_item="em"
	sel_item_index=-1
	for item in (Globals.healing_items):
		if Globals.healing_items[item]>1:
			healing_item_list.add_item(item+"   x"+str(Globals.healing_items[item]))
		elif Globals.healing_items[item]==1:
			healing_item_list.add_item(item)

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
	if sel_item.contains("HP Potion"):
		description.text="A simple healing potion.
		Heals 30 HP"
	if sel_item.contains("MP Potion"):
		description.text="A simple mana potion.
		Restores 20 MP"
	print(sel_item)


func _on_use_button_pressed() -> void:
	if current_screen==healing_item_list:
		var a_item:String
		var check_for_num=sel_item.findn("   x")
		if not check_for_num==-1:
			a_item=sel_item.left(check_for_num)
		else:
			a_item=sel_item
		if not sel_item=="em":
			if Globals.healing_items[a_item]==1:
				current_screen.remove_item(sel_item_index)
				Globals.healing_items.erase(a_item)
			else:
				Globals.healing_items[a_item]-=1
				if Globals.healing_items[a_item]==1:
					healing_item_list.set_item_text(sel_item_index, a_item)
				else:
					healing_item_list.set_item_text(sel_item_index, a_item+
					"   x"+str(Globals.healing_items[a_item]))
			visible=false
		if a_item=="HP Potion":
			item_used.emit("HP Potion")
		elif a_item=="MP Potion":
			item_used.emit("MP Potion")
		description.text=""
		healing_item_list.deselect_all()
		sel_item="em"
		sel_item_index=-1
		
