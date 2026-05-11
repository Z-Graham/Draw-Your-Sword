extends Node2D

const BASIC_BLADE = preload("uid://crkjolbw65b61")
const KATANA_BLADE = preload("uid://cvpbwashxw5ey")
const KRIS_BLADE = preload("uid://4bjggsin5t6m")
const SPEAR_BLADE = preload("uid://dmtcj5dvmtq61")

const BASIC_HANDLE = preload("uid://d3aj3q0l243gk")
const KATANA_HANDLE = preload("uid://bmduybjkkxx8y")
const KRIS_HANDLE = preload("uid://ex76qdnxorgc")
const SPEAR_HANDLE = preload("uid://dwval6y234p2y")




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
@onready var battle_history: VBoxContainer = $battle_history
@onready var anim: AnimationPlayer = $sword/anim
@onready var sword: Node2D = $sword
@onready var damage_label: Label = $Damage_label
@onready var blade_sprite: Sprite2D = $sword/blade
@onready var handle_sprite: Sprite2D = $sword/handle
@onready var stats_screen: ColorRect = $StatsScreen
@onready var tutorial_screen: Control = $"Tutorial screen"

signal battle_finished(exp_amount:int)

var enemy:String
var enemy_health=100
var enemy_status="none"
var sw_blade="basic"
var sw_handle="basic"
var sw_imbue="physical"
var draw_charge:int
var blade_skill_req=20
var handle_skill_req=10
var poison_count=0

var blade_mult=1.0
var handle_mult=1.0
var c_blade_skill="Double Slash"
var c_handle_skill="Bash"

var in_main=true
var in_battle=false
var in_inventory=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_charge=5
	sword.visible=false
	blade_sprite.texture=BASIC_BLADE
	handle_sprite.texture=BASIC_HANDLE
	damage_label.modulate=Color(1.0, 1.0, 1.0, 1.0)
	adjust_sprites()

func _process(delta:float)-> void:
	health_bar.max_value=Globals.player_stats["max_health"]
	health_bar.value=Globals.player_stats["max_health"]-Globals.player_stats["current_health"]
	health_label.text="Health: "+str(int(Globals.player_stats["current_health"]))+"/"+str(Globals.player_stats["max_health"])
	mp_bar.max_value=Globals.player_stats["max_MP"]
	mp_bar.value=Globals.player_stats["max_MP"]-Globals.player_stats["current_MP"]
	mp_label.text="MP: "+str(Globals.player_stats["current_MP"])+"/"+str(Globals.player_stats["max_MP"])

func battle_end():
	$ColorRect2.visible=true
	$ColorRect2.modulate=Color(1.0, 1.0, 1.0, 1.0)
	win_screen.reset()
	win_screen.visible=true
	var items=enemy_in_battle.loot()
	win_screen.set_items_obtained(items)
	win_screen.exp_gain(enemy_in_battle.enemy_stats["exp"])

func player_fight(blade:String,handle:String,imbue:String):
	fight_battle_menu.visible=false
	health_bar.visible=false
	mp_bar.visible=false
	player_battle.play("attack")
	
	if Globals.player_stats["current_MP"]<Globals.player_stats["max_MP"]-5:
		Globals.player_stats["current_MP"]+=5
	else:
		Globals.player_stats["current_MP"]=Globals.player_stats["max_MP"]
	var damage=damage_calc()
	damage=roundi(damage)
	damage_label.text=str(damage)
	if not sw_handle=="spear":
		anim.play("swing")
	else:
		anim.play("poke")
	await anim.animation_finished
	battle_history_update("The enemy took "+str(damage)+" damage.")
	enemy_in_battle.enemy_stats["health"]-=damage
	if enemy_in_battle.enemy_stats["health"]<=0:
		battle_end()
	else:
		enemy_fight()
	if pencil_bar.value<100:
		pencil_bar.value+=20
	player_battle.play("idle")
	await get_tree().create_timer(2).timeout

func _on_fight_button_pressed() -> void:
	main_battle_menu.visible=false
	fight_battle_menu.visible=true
	if Globals.tutorial_checks["fight"]==false:
		tutorial_screen.show_up("fight",3)
		Globals.tutorial_checks["fight"]=true

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
		player_battle.play("attack")
		var damage=0
		fight_battle_menu.visible=false
		health_bar.visible=false
		mp_bar.visible=false
		if sw_blade=="basic":
			battle_history_update("You used Double Slice!")
			Globals.player_stats["current_MP"]-=20
			damage=damage_calc()*.9
			damage=roundi(damage)
			damage_label.text=str(damage)
			if not sw_handle=="spear":
				anim.play("double_slash")
			else:
				anim.play("double stab")
			await get_tree().create_timer(.5).timeout
			var damage2=damage_calc()*.9
			damage2=roundi(damage2)
			damage_label.text=str(damage2)
			print(damage,damage2)
			damage=damage+damage2
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		elif sw_blade=="katana":
			battle_history_update("You used Precise Slash!")
			Globals.player_stats["current_MP"]-=25
			damage=damage_calc()*1.25
			if enemy_in_battle.enemy_stats["weakness"].size()>0:
				for i in enemy_in_battle.enemy_stats["weakness"]:
					if sw_imbue==i:
						damage*=1.5
			damage=roundi(damage)
			damage_label.text=str(damage)
			anim.play("precise_slash")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		elif sw_blade=="kris":
			battle_history_update("You used Serpent Strike!")
			Globals.player_stats["current_MP"]-=15
			damage=damage_calc()
			if enemy_in_battle.enemy_stats["weakness"].size()>0:
				for i in enemy_in_battle.enemy_stats["weakness"]:
					if i=="poison":
						damage*=1.5
			damage=roundi(damage)
			damage_label.text=str(damage)
			anim.play("Serpent strike")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
			var poi_chance=randi_range(1,4)
			if poi_chance==3:
				poison_count+=5
				enemy_in_battle.modulate=Color(0.317, 0.68, 0.0, 1.0)
				battle_history_update("The enemy is poisoned!")
		elif sw_blade=="spear":
			battle_history_update("You used Impaling Thrust!")
			Globals.player_stats["current_MP"]-=20
			damage=damage_calc_without_imbue()
			damage*=1.8
			damage=roundi(damage)
			damage_label.text=str(damage)
			anim.play("impaling thrust")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		enemy_in_battle.enemy_stats["health"]-=damage
		player_battle.play("idle")
		if enemy_in_battle.enemy_stats["health"]<=0:
			battle_end()
		else:
			enemy_fight()
		if pencil_bar.value<100:
			pencil_bar.value+=20

func _on_blade_skill_button_mouse_entered() -> void:
	if sw_blade=="basic":
		description.text="Double Slice: Two rapid attacks with your weapon.
		Costs 20MP"
	elif sw_blade=="katana":
		description.text="Precise Slash: A clean cut with the katana blade. 
		Attacks against enemy weaknesses are more effective.
		Costs 25MP"
	elif sw_blade=="kris":
		description.text="Serpent Strike: A venom imbued attack similar to a snake's strike.
		25% chance to inflict poison on the target.
		Costs 15MP"
	elif sw_blade=="spear":
		description.text="Impaling Thrust: A savage stab with the spearhead that ignores both 
		enemy weaknesses and resistances.
		Costs 20 MP"

func _on_blade_skill_button_mouse_exited() -> void:
	description.text=""

func _on_handle_skill_button_pressed() -> void:
	if Globals.player_stats["current_MP"]>=handle_skill_req or sw_handle=="spear":
		player_battle.play("attack")
		var damage=0
		fight_battle_menu.visible=false
		health_bar.visible=false
		mp_bar.visible=false
		if sw_handle=="basic":
			battle_history_update("You used Bash!")
			Globals.player_stats["current_MP"]-=10
			damage=damage_calc()
			damage*=1.3
			damage=roundi(damage)
			damage_label.text=str(damage)
			var confuse_chance=randi_range(1,3)
			if confuse_chance==2:
				enemy_status="confused"
				enemy_in_battle.modulate=Color(0.95, 1.0, 0.0, 1.0)
				battle_history_update("The enemy is confused!")
			anim.play("bash")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		elif sw_handle=="katana":
			battle_history_update("You used Quick Draw!")
			Globals.player_stats["current_MP"]-=5
			damage=damage_calc()
			damage*=.25
			damage=roundi(damage)
			damage_label.text=str(damage)
			anim.play("quick_draw")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		elif sw_handle=="kris":
			Globals.player_stats["current_MP"]-=10
			if Globals.player_stats["current_health"]<Globals.player_stats["max_health"]-20:
				Globals.player_stats["current_health"]+=20
			else:
				Globals.player_stats["current_health"]=Globals.player_stats["max_health"]
			battle_history_update("You used Ruby Heal.")
			battle_history_update("You healed 20 HP")
		elif sw_handle=="spear":
			battle_history_update("You used Stabbing Flurry!")
			Globals.player_stats["current_health"]-=20
			damage=damage_calc()
			damage*=2
			damage=roundi(damage)
			damage_label.text=str(damage)
			anim.play("stabbing flury")
			await anim.animation_finished
			battle_history_update("The enemy took "+str(damage)+" damage.")
		enemy_in_battle.enemy_stats["health"]-=damage
		player_battle.play("idle")
		if enemy_in_battle.enemy_stats["health"]<=0:
			battle_end()
		else:
			if not sw_handle=="katana":
				enemy_fight()
			else:
				fight_battle_menu.visible=true
				health_bar.visible=true
				mp_bar.visible=true
		if pencil_bar.value<100:
			pencil_bar.value+=20

func _on_handle_skill_button_mouse_entered() -> void:
	if sw_handle=="basic":
		description.text="Bash: A strike with the pommel of your blade with a chance to confuse the enemy.
		Costs 10MP"
	elif sw_handle=="katana":
		description.text="Quick Draw: A swift strike that sacrifices power for speed. Enemy will not counterattack.
		Costs 5MP"
	elif sw_handle=="kris":
		description.text="Ruby Heal: Using the rubies embedded in the hilt, perform a simple healing spell.
		costs 10MP"
	elif sw_handle=="spear":
		description.text="Stabbing Flurry: A flurry of stabs at the enemy followed by a downward stab
		that consumes HP instead of MP.
		costs 20HP"

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
		battle_history_update("You used a HP Potion.")
	elif item=="MP Potion":
		if Globals.player_stats["current_MP"]<Globals.player_stats["max_MP"]-20:
			Globals.player_stats["current_MP"]+=20
		else:
			Globals.player_stats["current_MP"]=Globals.player_stats["max_MP"]
		battle_history_update("You used a MP Potion.")
	elif item=="Inspect Lens":
		print(enemy_in_battle["weakness"])
		battle_history_update("You used an Inspect Lens.")
		await get_tree().create_timer(.75).timeout
		battle_history_update("The enemy has "+str(enemy_in_battle.enemy_stats["health"])+" health left.")
		await get_tree().create_timer(.75).timeout
		battle_history_update(check_weak())
		await get_tree().create_timer(.75).timeout
		battle_history_update(check_resist())
		await get_tree().create_timer(.75).timeout

func _on_draw_button_pressed() -> void:
	if pencil_bar.value==100:
		draw_screen.visible = true
		draw_screen.reset()
		pencil_bar.value=0

func reset():
	player_battle.play("idle")
	enemy_in_battle.global_rotation_degrees=0
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
	poison_count=0
	enemy_in_battle.name_of_en=enemy
	enemy_in_battle.set_sprite()
	if Globals.tutorial_checks["battle_screen"]==false:
		tutorial_screen.show_up("battle",2)
		Globals.tutorial_checks["battle_screen"]=true
	for child in battle_history.get_children():
		child.queue_free()
	enemy_in_battle.modulate=Color(1.0, 1.0, 1.0, 1.0)
	if enemy_in_battle.name_of_en=="goblin":
		for i in Globals.goblin_stats:
			enemy_in_battle.enemy_stats[i]=Globals.goblin_stats[i]
			
	if enemy_in_battle.name_of_en=="knight":
		for i in Globals.goblin_stats:
			enemy_in_battle.enemy_stats[i]=Globals.knight_stats[i]
			
	if enemy_in_battle.name_of_en=="sword bird":
		for i in Globals.goblin_stats:
			enemy_in_battle.enemy_stats[i]=Globals.bird_stats[i]
			
	if enemy_in_battle.name_of_en=="cloud":
		for i in Globals.goblin_stats:
			enemy_in_battle.enemy_stats[i]=Globals.cloud_stats[i]

func enemy_fight():
	await get_tree().create_timer(1).timeout
	if enemy_status=="confused":
		battle_history_update("The enemy can't attack due to confusion.")
		enemy_status="none"
		enemy_in_battle.modulate=Color(1.0, 1.0, 1.0, 1.0)
	else:
		if enemy=="goblin":
			enemy_in_battle.play("goblin attack")
			await enemy_in_battle.animation_finished
			var damage=roundf((enemy_in_battle.enemy_stats["attack"])+randf_range(-2,2))
			damage-=roundf(Globals.player_stats["defense"]/10.0)
			damage=roundi(damage)
			Globals.player_stats["current_health"]-=damage
			battle_history_update("You took "+str(damage)+" damage.")
			enemy_in_battle.play("goblin idle")
		elif enemy=="sword bird":
			anim.play("bird attack")
			await anim.animation_finished
			var damage=roundf((enemy_in_battle.enemy_stats["attack"])+randf_range(-2,2))
			damage-=roundf(Globals.player_stats["defense"]/10.0)
			damage=roundi(damage)
			Globals.player_stats["current_health"]-=damage
			battle_history_update("You took "+str(damage)+" damage.")
			anim.play("bird idle")
		elif enemy=="cloud":
			enemy_in_battle.play("cloud attack")
			await enemy_in_battle.animation_finished
			var damage=roundf((enemy_in_battle.enemy_stats["attack"])+randf_range(-2,2))
			damage-=roundf(Globals.player_stats["defense"]/10.0)
			damage=roundi(damage)
			Globals.player_stats["current_health"]-=damage
			battle_history_update("You took "+str(damage)+" damage.")
			enemy_in_battle.play("cloud idle")
		elif enemy=="knight":
			anim.play("knight attack")
			await anim.animation_finished
			var damage=roundf((enemy_in_battle.enemy_stats["attack"])+randf_range(-2,2))
			damage-=roundf(Globals.player_stats["defense"]/10.0)
			damage=roundi(damage)
			Globals.player_stats["current_health"]-=damage
			battle_history_update("You took "+str(damage)+" damage.")
			enemy_in_battle.play("knight_idle")
		else:
			var damage=roundf((enemy_in_battle.enemy_stats["attack"])+randf_range(-2,2))
			damage-=roundf(Globals.player_stats["defense"]/10.0)
			damage=roundi(damage)
			Globals.player_stats["current_health"]-=damage
			battle_history_update("You took "+str(damage)+" damage.")
	
	await get_tree().create_timer(.5).timeout
	if poison_count>0:
		enemy_in_battle.enemy_stats["health"]-=(enemy_in_battle.enemy_stats["health"]/16+1)
		battle_history_update("The enemy took "+str(enemy_in_battle.enemy_stats["health"]/16+1)+" poison damage.")
		poison_count-=1
		damage_label.text=str(enemy_in_battle.enemy_stats["health"]/16+1)
		anim.play("poison damage")
		if enemy_in_battle.enemy_stats["health"]<=0:
			battle_end()
	else:
		enemy_in_battle.modulate=Color(1.0, 1.0, 1.0, 1.0)
	fight_battle_menu.visible=true
	health_bar.visible=true
	mp_bar.visible=true

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
		blade_sprite.texture=BASIC_BLADE
	elif blade=="katana":
		blade_mult=1.0
		blade_sprite.texture=KATANA_BLADE
	elif blade=="kris":
		blade_mult=1.0
		blade_sprite.texture=KRIS_BLADE
	elif blade=="spear":
		blade_mult=1.0
		blade_sprite.texture=SPEAR_BLADE
		
	if handle=="basic":
		handle_mult=1.0
		handle_sprite.texture=BASIC_HANDLE
	elif handle=="katana":
		handle_mult=1.0
		handle_sprite.texture=KATANA_HANDLE
	elif handle=="kris":
		handle_mult=1.0
		handle_sprite.texture=KRIS_HANDLE
	elif handle=="spear":
		handle_mult=1.0
		handle_sprite.texture=SPEAR_HANDLE
	
	if blade=="basic" or blade=="spear":
		blade_skill_req=20
	elif blade=="katana":
		blade_skill_req=25
	elif blade=="kris":
		blade_skill_req=15
	if handle=="basic":
		handle_skill_req=10
	elif handle=="katana":
		handle_skill_req=5
	elif handle=="kris":
		handle_skill_req=10
	elif handle=="spear":
		handle_skill_req=0
	Globals.sword["blade"] = blade
	Globals.sword["handle"] = handle
	Globals.sword["imbue"] = imbue
	battle_history_update("You drew a new sword!")
	adjust_sprites()
	
	#update player sprite eventually

func damage_calc() -> int:
	var damage=Globals.player_stats["attack"]*blade_mult*handle_mult
	if enemy_in_battle.enemy_stats["weakness"].size()>0:
		for i in enemy_in_battle.enemy_stats["weakness"]:
			if sw_imbue==i:
				damage*=1.5
				print("fire")
				battle_history_update("It's super effective.")
	if enemy_in_battle.enemy_stats["resist"].size()>0:
		for i in enemy_in_battle.enemy_stats["resist"]:
			if sw_imbue==i:
				damage*=0.5
				battle_history_update("It's not very effective.")
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

func battle_history_update(label:String):
	var lab=Label.new()
	lab.text=label
	battle_history.add_child(lab)
	if battle_history.get_children().size()>6:
		battle_history.get_child(0).queue_free()

func adjust_sprites():
	if sw_blade=="basic":
		if sw_handle=="basic":
			handle_sprite.position=Vector2(-48,40)
		elif sw_handle=="katana":
			handle_sprite.position=Vector2(-60,51)
		elif sw_handle=="kris":
			handle_sprite.position=Vector2(-36,34)
		elif sw_handle=="spear":
			handle_sprite.position=Vector2(-84,76)
			
	elif sw_blade=="katana":
		if sw_handle=="basic":
			handle_sprite.position=Vector2(-66,63)
		elif sw_handle=="katana":
			handle_sprite.position=Vector2(-66,63)
		elif sw_handle=="kris":
			handle_sprite.position=Vector2(-54,56)
		elif sw_handle=="spear":
			handle_sprite.position=Vector2(-102,98)
			
	elif sw_blade=="kris":
		if sw_handle=="basic":
			handle_sprite.position=Vector2(-42,40)
		elif sw_handle=="katana":
			handle_sprite.position=Vector2(-54,51)
		elif sw_handle=="kris":
			handle_sprite.position=Vector2(-30,34)
		elif sw_handle=="spear":
			handle_sprite.position=Vector2(-78,76)
			
	elif sw_blade=="spear":
		if sw_handle=="basic":
			handle_sprite.position=Vector2(-36,34)
		elif sw_handle=="katana":
			handle_sprite.position=Vector2(-36,35)
		elif sw_handle=="kris":
			handle_sprite.position=Vector2(-24,22)
		elif sw_handle=="spear":
			handle_sprite.position=Vector2(-72,70)
			
	if sw_imbue=="physical":
		blade_sprite.modulate=Color(1.0, 1.0, 1.0, 1.0)
	elif sw_imbue=="fire":
		blade_sprite.modulate=Color(1.0, 0.0, 0.0, 1.0)
	elif sw_imbue=="lightning":
		blade_sprite.modulate=Color(1.0, 0.867, 0.0, 1.0)
	elif sw_imbue=="water":
		blade_sprite.modulate=Color(0.0, 0.0, 1.0, 1.0)
	elif sw_imbue=="wind":
		blade_sprite.modulate=Color(0.233, 1.0, 0.0, 1.0)
	elif sw_imbue=="rock":
		blade_sprite.modulate=Color(0.26, 0.169, 0.0, 1.0)
	elif sw_imbue=="ice":
		blade_sprite.modulate=Color(0.0, 1.0, 0.917, 1.0)

func _on_stats_screen_closed() -> void:
	win_screen.visible=true
	Globals.restore()

func _on_win_screen_level_up() -> void:
	win_screen.visible=false
	stats_screen.visible=true

func check_weak()-> String:
	var weak=enemy_in_battle.name_of_en.capitalize()+ "s are weak to "
	var size=enemy_in_battle.enemy_stats["weakness"].size()
	if size>0:
		for i in range(size):
			if size==2:
				if i<size-1:
					weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+" and "
				else:
					weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+" damage."
			elif size==1:
				weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+" damage."
			elif size>2:
				if i<size-2:
					weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+", "
				elif i<size-1:
					weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+", and "
				else:
					weak=weak+enemy_in_battle.enemy_stats["weakness"][i]+" damage."
	else:
		weak=weak+"nothing."
	return weak

func check_resist()->String:
	var weak=enemy_in_battle.name_of_en.capitalize()+ "s are resistant to "
	var size=enemy_in_battle.enemy_stats["resist"].size()
	if size>0:
		for i in range(size):
			if size==2:
				if i<size-1:
					weak=weak+enemy_in_battle.enemy_stats["resist"][i]+" and "
				else:
					weak=weak+enemy_in_battle.enemy_stats["resist"][i]+" damage."
			elif size==1:
				weak=weak+enemy_in_battle.enemy_stats["resist"][i]+" damage."
			elif size>2:
				if i<size-2:
					weak=weak+enemy_in_battle.enemy_stats["resist"][i]+", "
				elif i<size-1:
					weak=weak+enemy_in_battle.enemy_stats["resist"][i]+", and "
				else:
					weak=weak+enemy_in_battle.enemy_stats["resist"][i]+" damage."
	else:
		weak=weak+"nothing."
	return weak
