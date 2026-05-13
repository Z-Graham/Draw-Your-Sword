extends Control

@onready var exp_amount: Label = $"exp amount"
@onready var continue_button: Button = $continue
@onready var exp_bar: TextureProgressBar = $TextureProgressBar
@onready var level: Label = $level
@onready var exp_to_next: Label = $"exp to next"
@onready var you_win_label: Label = $YouWinLabel
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var item_label: Label = $itemLabel

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
	if !you_win_label.visible:
		var bs=get_tree().get_first_node_in_group("BattleScreenLayer")
		bs.visible=false
		visible=false
	else:
		you_win_label.visible = false
		item_label.visible=true
		exp_amount.visible = false
		exp_bar.visible = false
		level.visible = false
		exp_to_next.visible = false
		v_box_container.visible = true

func set_items_obtained(items:Array,key_have:bool):
	if items.size()>0:
		for item in items:
			var lab=Label.new()
			var settings = LabelSettings.new()
			settings.font_size=50
			lab.text=item
			lab.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
			lab.label_settings=settings
			v_box_container.add_child(lab)
			add_to_inventory(item)
	if key_have:
		var lab=Label.new()
		var settings = LabelSettings.new()
		settings.font_size=50
		lab.text="key"
		lab.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
		lab.label_settings=settings
		v_box_container.add_child(lab)

func add_to_inventory(text:String) -> void:
	if text=="HP Potion":
		Globals.healing_items["HP Potion"]+=1
	if text=="MP Potion":
		Globals.healing_items["MP Potion"]+=1
	if text=="Inspect Lens":
		Globals.battle_items["Inspect Lens"]+=1

func reset():
	you_win_label.visible = true
	item_label.visible=false
	exp_amount.visible = true
	exp_bar.visible = true
	level.visible = true
	exp_to_next.visible = true
	v_box_container.visible = false
	for lab in v_box_container.get_children():
		lab.queue_free()
