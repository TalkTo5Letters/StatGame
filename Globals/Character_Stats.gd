extends Node

#base stats of characters
var Characters = {
	"Chara1": {
		"name": "ShibuyaKanon",
		"scene_path": "res://Player/Character1/Chara1.tscn",
		"weapon": "Sword",
		"current_status": "alive", #dead, alive, locked
		"hp": 100,
		"max_hp": 100,
		"damage": 10,
		"speed": 400,
		"crit_dmg": 150,
		"crit_rate": 50,
		"attack_speed": 100,
		"equipped_artifacts" : [],
		"equipped_weapon": ""
	},

	"Chara2": {
		"name": "Gyahaha",
		"weapon": "Sword",
		"current_status": "alive", #dead, alive, locked
		"max_hp": 100,
		"hp": 100,
		"damage": 10,
		"speed": 400,
		"crit_dmg": 150,
		"crit_rate": 50,
		"attack_speed": 100,
		"equipped_artifacts" : [],
		"equipped_weapon": ""
	}
}
