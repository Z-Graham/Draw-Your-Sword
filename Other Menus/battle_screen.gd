extends Node2D
@onready var inventory: Control = $Inventory
@onready var main_battle_menu: Control = $Main_battle_menu
@onready var fight_battle_menu: Control = $fight_battle_menu
@onready var mp_bar: TextureProgressBar = $"MP bar"
@onready var health_bar: TextureProgressBar = $"health bar"
@onready var player_battle: AnimatedSprite2D = $player_battle
@onready var enemy_in_battle: AnimatedSprite2D = $enemy_in_battle
@onready var description: Label = $fight_battle_menu/Panel/Description
@onready var health_label: Label = $"health bar/Health Label"
@onready var mp_label: Label = $"MP bar/MP Label"
@onready var draw_screen: TextureRect = $DrawScreen
@onready var win_screen: ColorRect = $"Win Screen"
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var blade_label: Label = $"Main_battle_menu/Blade Label"
@onready var handle_label: Label = $"Main_battle_menu/Handle Label"
@onready var imbue_label: Label = $"Main_battle_menu/Imbue label"
@onready var pencil_bar: TextureProgressBar = $"Main_battle_menu/pencil bar"


var enemy_health=100
var enemy_status="none"
var sw_blade="basic"
var sw_handle="basic"
var sw_imbue="none"
var draw_charge:int
var blade_skill_req=20
var handle_skill_req=30

var blade_mult=1.0
var handle_mult=1.0


var in_main=true
var in_battle=false
var in_inventory=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_charge=5



func _process(delta:float)-> void:
	health_bar.max_value=Globals.player_stats["max_health"]
	health_bar.value=Globals.player_stats["max_health"]-Globals.player_stats["current_health"]
	health_label.text="Health: "+str(int(Globals.player_stats["current_health"]))+"/"+str(Globals.player_stats["max_health"])
	mp_bar.max_value=Globals.player_stats["max_MP"]
	mp_bar.value=Globals.player_stats["max_MP"]-Globals.player_stats["current_MP"]
	mp_label.text="MP: "+str(Globals.player_stats["current_MP"])+"/"+str(Globals.player_stats["max_MP"])
	#if Input.is_action_just_pressed("do_magic"):
		#Globals.player_stats["current_MP"] -= 1
	#if Input.is_action_just_pressed("hurt"):
		#Globals.player_stats["current_health"] -= 1



func battle_end():
	win_screen.c_room="res://rooms/over_world.tscn"
	$ColorRect2.visible=true
	win_screen.visible=true

func player_fight(blade:String,handle:String,imbue:String):
	fight_battle_menu.visible=false
	health_bar.visible=false
	mp_bar.visible=false
	if Globals.player_stats["current_MP"]<Globals.player_stats["max_MP"]-5:
		Globals.player_stats["current_MP"]+=5
	else:
		Globals.player_stats["current_MP"]=Globals.player_stats["max_MP"]
	var damage=damage_calc()
	damage=roundi(damage)
	$damage_label.text=str(damage)
	$damage_label.visible=true
	enemy_in_battle.enemy_stats["health"]-=damage
	if enemy_in_battle.enemy_stats["health"]<=0:
		battle_end()
	else:
		fight_battle_menu.visible=true
		health_bar.visible=true
		mp_bar.visible=true
		enemy_fight()
	if pencil_bar.value<100:
		pencil_bar.value+=20
	
	await get_tree().create_timer(2).timeout
	$damage_label.visible=false


func _on_fight_button_pressed() -> void:
	main_battle_menu.visible=false
	fight_battle_menu.visible=true

func _on_item_button_pressed() -> void:
	inventory.visible=true
	inventory.healing_item_list.visible=true
	inventory.battle_item_list.visible=false
	inventory.key_item_list.visible=false
	inventory.current_screen=inventory.healing_item_list


func _on_basic_button_pressed() -> void:
	player_fight(sw_blade,sw_handle,sw_imbue)

func _on_basic_button_mouse_entered() -> void:
	description.text="A basic attack with your weapon.
	Restores 5MP"

func _on_basic_button_mouse_exited() -> void:
	description.text=""

func _on_blade_skill_button_pressed() -> void:
	if Globals.player_stats["current_MP"]>=blade_skill_req:
		var damage=0
		fight_battle_menu.visible=false
		health_bar.visible=false
		mp_bar.visible=false
		if sw_blade=="basic":
			Globals.player_stats["current_MP"]-=20
			damage=damage_calc()*.9
			damage=roundi(damage)
			$damage_label.text=str(damage)
			$damage_label.visible=true
			await get_tree().create_timer(0.5).timeout
			var damage2=damage_calc()*.9
			damage2=roundi(damage2)
			$damage_label.text=str(damage2)
			$damage_label.visible=true
			damage=damage+damage2
		if sw_blade=="katana":
			Globals.player_stats["current_MP"]-=25
			damage=damage_calc()*1.25
			if enemy_in_battle.enemy_stats["weakness"].size()>0:
				for i in enemy_in_battle.enemy_stats["weakness"]:
					if sw_imbue==i:
						damage*=1.5
			damage=roundi(damage)
			$damage_label.text=str(damage)
			$damage_label.visible=true
		enemy_in_battle.enemy_stats["health"]-=damage
		if enemy_in_battle.enemy_stats["health"]<=0:
			battle_end()
		else:
			fight_battle_menu.visible=true
			health_bar.visible=true
			mp_bar.visible=true
			enemy_fight()
		if pencil_bar.value<100:
			pencil_bar.value+=20


func _on_blade_skill_button_mouse_entered() -> void:
	if sw_blade=="basic":
		description.text="Double Slice: Two rapid attacks with your weapon.
		Costs 20MP"
	if sw_blade=="katana":
		description.text="Precise Slash: A clean cut with the katana blade. 
		Attacks against enemy weaknesses are more effective
		Costs 25MP
		"

func _on_blade_skill_button_mouse_exited() -> void:
	description.text=""

func _on_handle_skill_button_pressed() -> void:
	if Globals.player_stats["current_MP"]>=handle_skill_req:
		var damage=0
		fight_battle_menu.visible=false
		health_bar.visible=false
		mp_bar.visible=false
		if sw_handle=="basic":
			Globals.player_stats["current_MP"]-=30
			damage=damage_calc_without_imbue()
			damage*=1.1
			damage=roundi(damage)
			var confuse_chance=randi_range(1,3)
			if confuse_chance==2:
				enemy_status="confused"
				enemy_in_battle.modulate=Color(0.95, 1.0, 0.0, 1.0)
		elif sw_handle=="katana":
			Globals.player_stats["current_MP"]-=5
			damage=damage_calc()
			damage*=.25
			damage=roundi(damage)
		$damage_label.text=str(damage)
		$damage_label.visible=true
		enemy_in_battle.enemy_stats["health"]-=damage
		if enemy_in_battle.enemy_stats["health"]<=0:
			battle_end()
		else:
			fight_battle_menu.visible=true
			health_bar.visible=true
			mp_bar.visible=true
			await get_tree().create_timer(2).timeout
			if not sw_handle=="katana":
				enemy_fight()
		if pencil_bar.value<100:
			pencil_bar.value+=20

func _on_handle_skill_button_mouse_entered() -> void:
	if sw_handle=="basic":
		description.text="Bash: A strike with the pommel of your blade with a chance to confuse the enemy.
		Costs 30MP"
	if sw_handle=="katana":
		description.text="Quick Draw: A swift strike that sacrifices power for speed. Enemy will not counterattack.
		Costs 5MP"

func _on_handle_skill_button_mouse_exited() -> void:
	description.text=""

func _on_back_button_pressed() -> void:
	main_battle_menu.visible=true
	fight_battle_menu.visible=false

func _on_inventory_item_used(item: Variant) -> void:
	if item=="HP Potion":
		if Globals.player_stats["current_health"]<Globals.player_stats["max_health"]-30:
			Globals.player_stats["current_health"]+=30
		else:
			Globals.player_stats["current_health"]=Globals.player_stats["max_health"]
	elif item=="MP Potion":
		if Globals.player_stats["current_MP"]<Globals.player_stats["max_MP"]-20:
			Globals.player_stats["current_MP"]+=20
		else:
			Globals.player_stats["current_MP"]=Globals.player_stats["max_MP"]

func _on_draw_button_pressed() -> void:
	if pencil_bar.value==100:
		draw_screen.visible = true
		draw_screen.reset()
		pencil_bar.value=0

func reset():
	draw_charge=5
	main_battle_menu.visible=true
	fight_battle_menu.visible=false
	inventory.visible=false
	color_rect_2.visible=false
	player_battle.visible=true
	enemy_in_battle.visible=true
	health_bar.visible=true
	mp_bar.visible=true
	in_main=true
	in_battle=false
	in_inventory=false
	inventory.update()
	if enemy_in_battle.name_of_en=="goblin":
		for i in Globals.goblin_stats:
			enemy_in_battle.enemy_stats[i]=Globals.goblin_stats[i]

func enemy_fight():
	if enemy_status=="confused":
		enemy_status="none"
		enemy_in_battle.modulate=Color(1.0, 1.0, 1.0, 1.0)
	else:
		var damage=roundf((enemy_in_battle.enemy_stats["attack"]/2)+randf_range(-2,2))
		damage-=roundf(Globals.player_stats["defense"]/10.0)
		Globals.player_stats["current_health"]-=damage


func _on_draw_screen_draw_screen_closed(blade: Variant, handle: Variant, imbue: Variant) -> void:
	sw_blade=blade
	sw_handle=handle
	sw_imbue=imbue
	blade_label.text="blade: "+blade
	handle_label.text="handle: "+handle
	imbue_label.text="imbue: "+imbue
	pencil_bar.value=0
	if blade=="basic":
		blade_mult=1.0
	if handle=="basic":
		handle_mult=1.0
	if blade=="basic":
		blade_skill_req=20
	elif blade=="katana":
		blade_skill_req=25
	if handle=="basic":
		handle_skill_req=30
	Globals.sword["blade"] = blade
	Globals.sword["handle"] = handle
	Globals.sword["imbue"] = imbue
	
	#update player sprite eventually

func damage_calc() -> int:
	var damage=Globals.player_stats["attack"]*blade_mult*handle_mult
	if enemy_in_battle.enemy_stats["weakness"].size()>0:
		for i in enemy_in_battle.enemy_stats["weakness"]:
			if sw_imbue==i:
				damage*=2
	if enemy_in_battle.enemy_stats["resist"].size()>0:
		for i in enemy_in_battle.enemy_stats["resist"]:
			if sw_imbue==i:
				damage*=0.5
	damage-=roundf(enemy_in_battle.enemy_stats["defense"]/10.0)
	damage*=randf_range(0.8,1.2)
	damage=roundi(damage)
	return damage
	
func damage_calc_without_imbue() -> int:
	var damage=Globals.player_stats["attack"]*blade_mult*handle_mult
	damage-=roundf(enemy_in_battle.enemy_stats["defense"]/10.0)
	damage*=randf_range(0.8,1.2)
	damage=roundi(damage)
	return damage
