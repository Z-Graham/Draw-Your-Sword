extends Control

@onready var exp_amount: Label = $"exp amount"
@onready var continue_button: Button = $continue
@onready var exp_bar: TextureProgressBar = $TextureProgressBar
@onready var level: Label = $level
@onready var exp_to_next: Label = $"exp to next"

func _ready() -> void:
	exp_bar.max_value=Globals.exp_requirements["1"]
	exp_gain(16)

func exp_gain(exp:int):
	exp_amount.text="+ "+str(exp)
	print("exp",exp)
	for i in range(exp):
		exp_bar.value+=1
		print(i)
		await get_tree().create_timer(.05).timeout
		if exp_bar.value==exp_bar.max_value:
			print("level_up")
			exp_bar.value=0
			Globals.level+=1
			level.text="Level: "+str(Globals.level)
			exp_bar.max_value=Globals.exp_requirements[str(Globals.level)]
	if Globals.player_stats["exp"]+exp<Globals.exp_requirements[str(Globals.level)]:
		print(Globals.player_stats["exp"])
		exp_to_next.text="EXP to next: "+(str(
		Globals.exp_requirements[str(Globals.level)]-Globals.player_stats["exp"]))
	else:
		pass

func _on_continue_pressed() -> void:
	var bs=get_tree().get_first_node_in_group("BattleScreenLayer")
	bs.visible=false
	visible=false
