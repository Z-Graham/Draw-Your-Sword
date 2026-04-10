extends TextureRect


@onready var tab_container: TabContainer = $TabContainer

@onready var blade: TabBar = $TabContainer/Blade
@onready var handle: TabBar = $TabContainer/Handle
@onready var imbue: TabBar = $TabContainer/Imbue
@onready var blade_list: ItemList = $blade_list
@onready var blade_sprite: AnimatedSprite2D = $sword/blade
@onready var handle_list: ItemList = $handle_list
@onready var handle_sprite: AnimatedSprite2D = $sword/handle
@onready var imbue_list: ItemList = $imbue_list

var sel_blade=""
var sel_handle=""
var sel_imbue=""
var current_tab:TabBar

func _ready() -> void:
	blade_sprite.play("nothing_selected")
	handle_sprite.play("nothing_selected")
	current_tab=blade

func _on_change_tab_button_pressed() -> void:
	if tab_container.current_tab < tab_container.get_tab_count() - 1:
		tab_container.current_tab += 1
		#change to menu for current tab
	if current_tab==blade:
		if sel_blade=="basic":
			blade_sprite.play("basic_set")
		current_tab=handle
		blade_list.visible=false
		handle_list.visible=true
	elif current_tab==handle:
		if sel_handle=="basic":
			handle_sprite.play("basic_set")
		current_tab=handle
		handle_list.visible=false
		imbue_list.visible=true

func _on_close_button_pressed() -> void:
	visible = false
	# will return to previous scene later




func _on_blade_list_item_selected(index: int) -> void:
	sel_blade=blade_list.get_item_text(index)
	if sel_blade=="basic":
		blade_sprite.play("basic_flash")
	print(sel_blade)


func _on_handle_list_item_selected(index: int) -> void:
	sel_handle=handle_list.get_item_text(index)
	if sel_handle=="basic":
		handle_sprite.play("basic_flash")
