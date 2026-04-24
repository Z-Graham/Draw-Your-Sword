extends Node

var player_max_health=100
var player_max_MP=50
var player_current_health=player_max_health
var player_current_MP=player_max_MP
var player_stats={"max_health":100, "current_health":100, 
"max_MP":50, "current_MP":50, "attack":15, "defense":10, "exp":0}

#requirements are indicative of exp to get past the level
var exp_requirements={"1":15,"2":20,"3":30,"4":30,"5":30,"6":40,"7":50,"8":50,"9":100}
var level=1

var healing_items={"HP Potion":0, "MP Potion":0}

var sword = {"blade":"basic","handle":"basic","imbue":"none"}

# Arrays of unlocked sword parts
var known_blades = ["basic",]
var known_handles = ["basic",]
var known_imbues = ["none",]

var goblin_stats={"health":100,"defense":5,"attack":10,
"resist":[],"weakness":["fire"],"exp":10}
#signal change_stats
