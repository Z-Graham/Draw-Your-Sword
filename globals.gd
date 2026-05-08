extends Node

var player_max_health=100
var player_max_MP=50
var player_current_health=player_max_health
var player_current_MP=player_max_MP
var player_stats={"max_health":100, "current_health":100, 
"max_MP":50, "current_MP":50, "attack":10, "defense":10, "exp":0}

signal battle_started()

#requirements are indicative of exp to get past the level
var exp_requirements={"1":15,"2":20,"3":30,"4":30,"5":30,"6":40,"7":50,"8":50,"9":100}
var level=1
var stat_points=0

var healing_items={"HP Potion":0, "MP Potion":0}
var battle_items={"Inspect Lens":0}

var sword = {"blade":"basic","handle":"basic","imbue":"none"}

var tutorial_checks={"battle_screen":false,"fight":false,"draw_1":false}

# Arrays of unlocked sword parts
var known_blades = ["basic","katana","kris","spear"]
var known_handles = ["basic","katana","kris","spear"]
var known_imbues = ["none","fire"]

var goblin_stats={"health":50,"defense":7,"attack":10,
"resist":[],"weakness":["fire"],"exp":5}

var knight_stats={"health":100,"defense":15,"attack":10,
"resist":["none","rock"],"weakness":["fire","lightning"],"exp":15}

var bird_stats={"health":75,"defense":5,"attack":15,
"resist":[],"weakness":["lightning","rock"],"exp":10}

var cloud_stats={"health":60,"defense":8,"attack":12,
"resist":["lightning"],"weakness":["air"],"exp":5}

var keys := 0
#signal change_stats

func restore():
	player_stats["current_health"]=player_stats["max_health"]
	player_stats["current_MP"]=player_stats["max_MP"]
