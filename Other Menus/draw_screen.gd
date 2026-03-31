extends TextureRect


@onready var tab_container: TabContainer = $TabContainer

@onready var blade: TabBar = $TabContainer/Blade
@onready var handle: TabBar = $TabContainer/Handle
@onready var imbue: TabBar = $TabContainer/Imbue



func _on_change_tab_button_pressed() -> void:
	if tab_container.current_tab < tab_container.get_tab_count() - 1:
		tab_container.current_tab += 1
		#change to menu for current tab

func _on_close_button_pressed() -> void:
	get_tree().quit()
	# will return to previous scene later
