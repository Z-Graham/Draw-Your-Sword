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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
