extends AnimatedSprite2D

@export var health=100
@export var defense=5
@export var attack=10
@export var resistances=[]
@export var weakness=[]
@export var exp=10
@export var name_of_en="goblin"

var enemy_stats={"health":health,"defense":defense,"attack":attack,
"resist":resistances,"weakness":weakness,"exp":exp}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_sprite():
	if name_of_en=="goblin":
		play("goblin idle")
	elif name_of_en=="sword bird":
		play("bird idle")
	elif name_of_en=="knight":
		play("knight idle")
	elif name_of_en=="cloud":
		animation="cloud attack"

func loot() -> Array:
	var stuff=[]
	var loot_val=randi_range(1,10)
	if loot_val>4 and loot_val<7 or loot_val==10:
		stuff.append("HP Potion")
	if loot_val>7 and loot_val<=10:
		stuff.append("MP Potion")
	if loot_val==1:
		stuff.append("Inspect Lens")
	return stuff
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta: float) -> void:
	pass
