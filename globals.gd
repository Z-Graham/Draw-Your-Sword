extends Node

var player_max_health=100
var player_max_MP=50
var player_current_health=player_max_health
var player_current_MP=player_max_MP
var player_stats={"max_health":100, "current_health":100, 
"max_MP":50, "current_MP":50, "attack":20, "defense":10}

var healing_items={"HP Potion":0, "MP Potion":0}

var sword = {"blade":"basic","handle":"basic","imbue":"none"}

var goblin_stats={"health":100,"defense":5,"attack":10,
"resist":[],"weakness":["fire"]}
#signal change_stats
