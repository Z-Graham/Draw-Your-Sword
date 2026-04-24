extends ColorRect

@onready var max_health_value_label: Label = $GridContainer/VBoxContainer/MaxHealthValueLabel
@onready var max_mp_value_label: Label = $GridContainer/VBoxContainer2/MaxMPValueLabel
@onready var attack_value_label: Label = $GridContainer/VBoxContainer3/AttackValueLabel
@onready var defense_value_label: Label = $GridContainer/VBoxContainer4/DefenseValueLabel


func _on_health_increase_button_pressed() -> void:
	Globals.player_stats["max_health"] += 20
	max_health_value_label.text = str(Globals.player_stats["max_health"])


func _on_mp_increase_button_pressed() -> void:
	pass # Replace with function body.


func _on_attack_increase_button_pressed() -> void:
	pass # Replace with function body.


func _on_defense_increase_button_pressed() -> void:
	pass # Replace with function body.
