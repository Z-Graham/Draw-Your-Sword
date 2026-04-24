extends Node

var player_max_health=100
var player_max_MP=50
var player_current_health=player_max_health
var player_current_MP=player_max_MP
var player_stats={"max_health":100, "current_health":100, 
"max_MP":50, "current_MP":50, "attack":15, "defense":10, "Exp":0}

var exp_requirements={"2":15,"3":20,"4":30,"5":30,"6":30,"7":40,"8":50,"9":50,"10":100}
var level=1

var healing_items={"HP Potion":0, "MP Potion":0}

var sword = {"blade":"basic","handle":"basic","imbue":"none"}

# Arrays of unlocked sword parts
var known_blades = ["basic",]
var known_handles = ["basic",]
var known_imbues = ["none",]

var goblin_stats={"health":100,"defense":5,"attack":10,
"resist":[],"weakness":["fire"]}
#signal change_stats
