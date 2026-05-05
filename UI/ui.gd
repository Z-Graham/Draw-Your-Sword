extends CanvasLayer




func _on_close_button_pressed() -> void:
	visible = false


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on==true:
		for key in Globals.tutorial_checks.keys():
			Globals.tutorial_checks[key]=true
	else:
		for key in Globals.tutorial_checks.keys():
			Globals.tutorial_checks[key]=false
