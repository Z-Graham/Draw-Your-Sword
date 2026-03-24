extends Node2D

var player_health=100
var enemy_health=100
var blade="normal"
var handle="normal"
var imbue="none"
var draw_charge:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_charge=5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_fight(blade:String,handle:String,imbue:String):
	print("fight")


func _on_fight_button_pressed() -> void:
	player_fight(blade, handle, imbue)


func _on_item_button_pressed() -> void:
	pass # Replace with function body.
