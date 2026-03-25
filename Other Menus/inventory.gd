extends Control
@onready var battle_item_list: ItemList = $BattleItemList
@onready var healing_item_list: ItemList = $HealingItemList
@onready var key_item_list: ItemList = $KeyItemList
@onready var description: Label = $Panel/description


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	




func _on_x_button_pressed() -> void:
	visible=false


func _on_heal_tab_pressed() -> void:
	healing_item_list.visible=true
	battle_item_list.visible=false
	key_item_list.visible=false


func _on_battle_tab_pressed() -> void:
	healing_item_list.visible=false
	battle_item_list.visible=true
	key_item_list.visible=false


func _on_key_tab_pressed() -> void:
	healing_item_list.visible=false
	battle_item_list.visible=false
	key_item_list.visible=true


func _on_healing_item_list_item_selected(index: int) -> void:
	var sel_item=healing_item_list.get_item_text(index)
	if sel_item=="HP Potion":
		description.text="A simple healing poition.
		Heals 30 HP"
