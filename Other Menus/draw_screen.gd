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
@onready var change_tab_button: Button = $ChangeTabButton

signal draw_screen_closed(blade,handle,imbue)
var sel_blade=""
var sel_handle=""
var sel_imbue=""
var current_tab:TabBar

func _ready() -> void:
	blade_sprite.play("nothing_selected")
	handle_sprite.play("nothing_selected")
	current_tab=blade

func _on_change_tab_button_pressed() -> void:
		#change to menu for current tab
	if current_tab==blade:
		if not sel_blade=="":
			if tab_container.current_tab < tab_container.get_tab_count() - 1:
				tab_container.current_tab += 1
				current_tab=handle
				blade_list.visible=false
				handle_list.visible=true
		if sel_blade=="basic":
			blade_sprite.play("basic_set")
	elif current_tab==handle:
		if not sel_handle=="":
			if tab_container.current_tab < tab_container.get_tab_count() - 1:
				tab_container.current_tab += 1
				current_tab=imbue
				handle_list.visible=false
				imbue_list.visible=true
		if sel_handle=="basic":
			handle_sprite.play("basic_set")
	elif current_tab==imbue:
		if not sel_imbue=="":
			if tab_container.current_tab < tab_container.get_tab_count() - 1:
				tab_container.current_tab += 1
			imbue_list.visible=false
			change_tab_button.visible=false
		if sel_blade=="basic":
			blade_sprite.play("basic_set")

func _on_close_button_pressed() -> void:
	visible = false
	draw_screen_closed.emit(sel_blade,sel_handle,sel_imbue)




func _on_blade_list_item_selected(index: int) -> void:
	sel_blade=blade_list.get_item_text(index)
	if sel_blade=="basic":
		blade_sprite.play("basic_flash")
		blade_sprite.global_position=Vector2(261,79)
	print(sel_blade)


func _on_handle_list_item_selected(index: int) -> void:
	sel_handle=handle_list.get_item_text(index)
	if sel_handle=="basic":
		handle_sprite.play("basic_flash")


func _on_imbue_list_item_selected(index: int) -> void:
	sel_imbue=imbue_list.get_item_text(index)
	if sel_imbue=="none":
		blade_sprite.modulate=Color(1.0, 1.0, 1.0, 1.0)
	if sel_blade=="basic":
		blade_sprite.play("basic_flash")

func reset():
	sel_blade=""
	sel_handle=""
	sel_imbue=""
	current_tab=blade
	blade_list.visible=true
	handle_list.visible=false
	imbue_list.visible=false
	tab_container.current_tab=0
	blade_list.deselect_all()
	handle_list.deselect_all()
	imbue_list.deselect_all()
	blade_sprite.play("nothing_selected")
	handle_sprite.play("nothing_selected")
	blade_sprite.modulate=Color(1,1,1,1)
	change_tab_button.visible=true
