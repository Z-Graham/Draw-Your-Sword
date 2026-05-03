extends Control

@onready var exp_amount: Label = $"exp amount"
@onready var continue_button: Button = $continue
@onready var exp_bar: TextureProgressBar = $TextureProgressBar
@onready var level: Label = $level
@onready var exp_to_next: Label = $"exp to next"

signal level_up()

func _ready() -> void:
	exp_bar.max_value=Globals.exp_requirements["1"]
	#exp_gain(20)

func exp_gain(exp:int):
	var c_level=str(Globals.level)
	exp_amount.text="+ "+str(exp)
	Globals.player_stats["exp"]+=exp
	for i in range(exp):
		exp_bar.value+=1
		await get_tree().create_timer(.05).timeout
		if exp_bar.value==exp_bar.max_value:
			exp_bar.value=0
			Globals.level+=1
			Globals.stat_points+=5
			level.text="Level: "+str(Globals.level)
			exp_bar.max_value=Globals.exp_requirements[str(Globals.level)]
	if (Globals.player_stats["exp"])<Globals.exp_requirements[c_level]:
		exp_to_next.text="EXP to next: "+(str(
		Globals.exp_requirements[c_level]-Globals.player_stats["exp"]))
	else:
		level_up.emit()
		Globals.player_stats["exp"]=(Globals.player_stats["exp"]
		-Globals.exp_requirements[c_level])
		exp_to_next.text="EXP to next: "+(str(
		Globals.exp_requirements[str(Globals.level)]-Globals.player_stats["exp"]))
	continue_button.visible=true

func _on_continue_pressed() -> void:
	var bs=get_tree().get_first_node_in_group("BattleScreenLayer")
	bs.visible=false
	visible=false
