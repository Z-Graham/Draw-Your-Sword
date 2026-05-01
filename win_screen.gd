extends Control

@onready var exp_amount: Label = $"exp amount"
@onready var continue_button: Button = $continue
@onready var exp_bar: TextureProgressBar = $TextureProgressBar
@onready var level: Label = $level
@onready var exp_to_next: Label = $"exp to next"


func exp_gain(exp:int):
	exp_amount.text="+ "+str(exp)
	for i in range(exp):
		exp_bar.value+=1
		await get_tree().create_timer(.05).timeout

func _on_continue_pressed() -> void:
	var bs=get_tree().get_first_node_in_group("BattleScreenLayer")
	bs.visible=false
	visible=false
