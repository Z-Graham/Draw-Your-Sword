extends ColorRect

@onready var max_health_value_label: Label = $GridContainer/VBoxContainer/MaxHealthValueLabel
@onready var max_mp_value_label: Label = $GridContainer/VBoxContainer2/MaxMPValueLabel
@onready var attack_value_label: Label = $GridContainer/VBoxContainer3/AttackValueLabel
@onready var defense_value_label: Label = $GridContainer/VBoxContainer4/DefenseValueLabel

@onready var health_decrease_button: Button = $GridContainer/VBoxContainer/HealthDecreaseButton
@onready var mp_decrease_button: Button = $GridContainer/VBoxContainer2/MPDecreaseButton
@onready var attack_decrease_button: Button = $GridContainer/VBoxContainer3/AttackDecreaseButton
@onready var defense_decrease_button: Button = $GridContainer/VBoxContainer4/DefenseDecreaseButton

@onready var stat_points: Label = $stat_points
@onready var confirm_button: Button = $confirm_button

var added_health=0
var added_MP=0
var added_attack=0
var added_defense=0
var stat_points_left:int

signal closed

func _on_health_increase_button_pressed() -> void:
	if stat_points_left>0:
		added_health+=5
		stat_points_left-=1
		health_decrease_button.visible=true
		max_health_value_label.text=str(Globals.player_stats["max_health"])+" + "+str(added_health)
		any_button_pressed()
func _on_mp_increase_button_pressed() -> void:
	if stat_points_left>0:
		added_MP+=5
		stat_points_left-=1
		mp_decrease_button.visible=true
		max_mp_value_label.text=str(Globals.player_stats["max_MP"])+" + "+str(added_MP)
		any_button_pressed()
func _on_attack_increase_button_pressed() -> void:
	if stat_points_left>0:
		added_attack+=1
		stat_points_left-=1
		attack_decrease_button.visible=true
		attack_value_label.text=str(Globals.player_stats["attack"])+" + "+str(added_attack)
		any_button_pressed()

func _on_defense_increase_button_pressed() -> void:
	if stat_points_left>0:
		added_defense+=1
		stat_points_left-=1
		defense_decrease_button.visible=true
		defense_value_label.text=str(Globals.player_stats["defense"])+" + "+str(added_defense)
		any_button_pressed()

func _on_health_decrease_button_pressed() -> void:
	added_health-=5
	stat_points_left+=1
	if added_health==0:
		max_health_value_label.text=str(Globals.player_stats["max_health"])
		health_decrease_button.visible=false
	else:
		max_health_value_label.text=str(Globals.player_stats["max_health"])+" + "+str(added_health)


func _on_mp_decrease_button_pressed() -> void:
	added_MP-=5
	stat_points_left+=1
	if added_MP==0:
		max_mp_value_label.text=str(Globals.player_stats["max_MP"])
		mp_decrease_button.visible=false
	else:
		max_mp_value_label.text=str(Globals.player_stats["max_MP"])+" + "+str(added_MP)



func _on_attack_decrease_button_pressed() -> void:
	added_attack-=1
	stat_points_left+=1
	if added_attack==0:
		attack_value_label.text=str(Globals.player_stats["attack"])
		attack_decrease_button.visible=false
	else:
		attack_value_label.text=str(Globals.player_stats["attack"])+" + "+str(added_attack)



func _on_defense_decrease_button_pressed() -> void:
	added_defense-=1
	stat_points_left+=1
	if added_defense==0:
		defense_value_label.text=str(Globals.player_stats["defense"])
		defense_decrease_button.visible=false
	else:
		defense_value_label.text=str(Globals.player_stats["defense"])+" + "+str(added_defense)



func any_button_pressed() -> void:
	stat_points.text="Stat points available: "+str(stat_points_left)
	if stat_points_left==0:
		confirm_button.visible=true
	else:
		confirm_button.visible=false


func _on_confirm_button_pressed() -> void:
	Globals.stat_points=0
	Globals.player_stats["max_health"]+=added_health
	Globals.player_stats["max_MP"]+=added_MP
	Globals.player_stats["attack"]+=added_attack
	Globals.player_stats["defense"]+=added_defense
	attack_value_label.text=str(Globals.player_stats["attack"])
	defense_value_label.text=str(Globals.player_stats["defense"])
	max_health_value_label.text=str(Globals.player_stats["max_health"])
	max_mp_value_label.text=str(Globals.player_stats["max_MP"])
	health_decrease_button.visible=false
	mp_decrease_button.visible=false
	attack_decrease_button.visible=false
	defense_decrease_button.visible=false
	confirm_button.visible=false
	added_health=0
	added_defense=0
	added_MP=0
	added_attack=0
	visible=false
	closed.emit()


func _on_visibility_changed() -> void:
	stat_points_left=Globals.stat_points
