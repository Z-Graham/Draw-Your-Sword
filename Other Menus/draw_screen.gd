extends TextureRect


@onready var tab_container: TabContainer = $TabContainer

@onready var blade: TabBar = $TabContainer/Blade
@onready var handle: TabBar = $TabContainer/Handle
@onready var imbue: TabBar = $TabContainer/Imbue
@onready var blade_list: ItemList = $blade_list
@onready var blade_sprite: AnimatedSprite2D = $blade
@onready var handle_list: ItemList = $handle_list
@onready var handle_sprite: AnimatedSprite2D = $handle
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
		elif sel_blade=="katana":
			blade_sprite.play("katana_set")
		elif sel_blade=="kris":
			blade_sprite.play("kris_set")
		elif sel_blade=="spear":
			blade_sprite.play("spear_set")
	elif current_tab==handle:
		if not sel_handle=="":
			if tab_container.current_tab < tab_container.get_tab_count() - 1:
				tab_container.current_tab += 1
				current_tab=imbue
				handle_list.visible=false
				imbue_list.visible=true
		if sel_handle=="basic":
			handle_sprite.play("basic_set")
		if sel_handle=="katana":
			handle_sprite.play("katana_set")
		elif sel_handle=="kris":
			handle_sprite.play("kris_set")
		elif sel_handle=="spear":
			handle_sprite.play("spear_set")
	elif current_tab==imbue:
		if not sel_imbue=="":
			$CloseButton.visible=true
			if tab_container.current_tab < tab_container.get_tab_count() - 1:
				tab_container.current_tab += 1
			imbue_list.visible=false
			change_tab_button.visible=false
		if sel_blade=="basic":
			blade_sprite.play("basic_set")
		elif sel_blade=="katana":
			blade_sprite.play("katana_set")
		elif sel_blade=="kris":
			blade_sprite.play("kris_set")
		elif sel_blade=="spear":
			blade_sprite.play("spear_set")

func _on_close_button_pressed() -> void:
	visible = false
	draw_screen_closed.emit(sel_blade,sel_handle,sel_imbue)




func _on_blade_list_item_selected(index: int) -> void:
	blade_sprite.stop()
	sel_blade=blade_list.get_item_text(index)
	if sel_blade=="basic":
		blade_sprite.play("basic_flash")
	elif sel_blade=="katana":
		blade_sprite.play("katana_flash")
	elif sel_blade=="kris":
		blade_sprite.play("kris_flash")
	elif sel_blade=="spear":
		blade_sprite.play("spear_flash")


func _on_handle_list_item_selected(index: int) -> void:
	sel_handle=handle_list.get_item_text(index)
	update_position()
	handle_sprite.stop()
	if sel_handle=="basic":
		handle_sprite.play("basic_flash")
	elif sel_handle=="katana":
		handle_sprite.play("katana_flash")
	elif sel_handle=="kris":
		handle_sprite.play("kris_flash")
	elif sel_handle=="spear":
		handle_sprite.play("spear_flash")
	


func _on_imbue_list_item_selected(index: int) -> void:
	sel_imbue=imbue_list.get_item_text(index)
	if sel_imbue=="none":
		blade_sprite.modulate=Color(1.0, 1.0, 1.0, 1.0)
	elif sel_imbue=="fire":
		blade_sprite.modulate=Color(1.0, 0.0, 0.0, 1.0)
	if sel_blade=="basic":
		blade_sprite.play("basic_flash")
	elif sel_blade=="katana":
		blade_sprite.play("katana_flash")
	elif sel_blade=="kris":
		blade_sprite.play("kris_flash")
	elif sel_blade=="spear":
		blade_sprite.play("spear_flash")

func reset():
	# make lists only show known blades
	blade_list.clear()
	handle_list.clear()
	imbue_list.clear()
	for b in Globals.known_blades:
		blade_list.add_item(b)
	for h in Globals.known_handles:
		handle_list.add_item(h)
	for i in Globals.known_imbues:
		imbue_list.add_item(i)
	
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


func update_position():
	if sel_blade=="basic":
		if sel_handle=="basic":
			blade_sprite.global_position=Vector2(504,267)
			handle_sprite.global_position=Vector2(345,374)
		elif sel_handle=="katana":
			blade_sprite.global_position=Vector2(554,285)
			handle_sprite.global_position=Vector2(356,418)
		elif sel_handle=="kris":
			blade_sprite.global_position=Vector2(554,330)
			handle_sprite.global_position=Vector2(437,421)
		elif sel_handle=="spear":
			blade_sprite.global_position=Vector2(556,268)
			handle_sprite.global_position=Vector2(337,421)
	if sel_blade=="katana":
		if sel_handle=="basic":
			blade_sprite.global_position=Vector2(520,274)
			handle_sprite.global_position=Vector2(304,442)
		elif sel_handle=="katana":
			blade_sprite.global_position=Vector2(562,244)
			handle_sprite.global_position=Vector2(304,442)
		elif sel_handle=="kris":
			blade_sprite.global_position=Vector2(613,268)
			handle_sprite.global_position=Vector2(437,421)
		elif sel_handle=="spear":
			blade_sprite.global_position=Vector2(574,238)
			handle_sprite.global_position=Vector2(337,421)
	if sel_blade=="kris":
		if sel_handle=="basic":
			blade_sprite.global_position=Vector2(526,299)
			handle_sprite.global_position=Vector2(387,421)
		elif sel_handle=="katana":
			blade_sprite.global_position=Vector2(497,335)
			handle_sprite.global_position=Vector2(339,457)
		elif sel_handle=="kris":
			blade_sprite.global_position=Vector2(512,361)
			handle_sprite.global_position=Vector2(413,452)
		elif sel_handle=="spear":
			blade_sprite.global_position=Vector2(598,259)
			handle_sprite.global_position=Vector2(340,460)
	if sel_blade=="spear":
		if sel_handle=="basic":
			blade_sprite.global_position=Vector2(521,312)
			handle_sprite.global_position=Vector2(402,403)
		elif sel_handle=="katana":
			blade_sprite.global_position=Vector2(520,312)
			handle_sprite.global_position=Vector2(400.5,403.5)
		elif sel_handle=="spear":
			blade_sprite.global_position=Vector2(576,238)
			handle_sprite.global_position=Vector2(337,421)
		elif sel_handle == "kris":
			blade_sprite.global_position=Vector2(521,262)
			handle_sprite.global_position=Vector2(462,338)
	
