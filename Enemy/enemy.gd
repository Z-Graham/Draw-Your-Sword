extends Area2D

@export_enum("goblin", "cloud","knight","sword bird") var type := "goblin"
@export var has_key := false

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var key: AnimatedSprite2D = $Key


func _ready() -> void:
	if has_key:
		key.visible = true
		key.play("default")
	if type=="goblin":
		sprite_2d.play("goblin")
	elif type=="cloud":
		sprite_2d.play("cloud")
	elif type=="knight":
		sprite_2d.play("knight")
	elif type=="sword bird":
		sprite_2d.play("bird")

func _on_body_entered(_body: Node2D) -> void:
	var battle_screen_layer := get_tree().get_first_node_in_group("BattleScreenLayer")
	battle_screen_layer.visible = true
	var battle_screen=get_tree().get_first_node_in_group("BattleScreenLayer").get_child(0)
	battle_screen.enemy=type
	if has_key:
		battle_screen.key_have=true
	else:
		battle_screen.key_have=false
	battle_screen.reset()
	if has_key:
		Globals.keys += 1
	queue_free()
