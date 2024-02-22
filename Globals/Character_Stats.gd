extends Node

#base stats of characters
var Characters = {
	"Chara1": {
		"name": "Shibuya Kanon",
		"scene_path": "res://Player/Character1/Chara1.tscn",
		"texture": "res://Graphics/Player/Kanon_Shibuya.png",
		"weapon": "Sword",
		"current_status": "alive", #dead, alive, locked
		"hp": 100,
		"max_hp": 100,
		"damage": 10,
		"speed": 400,
		"crit_dmg": 150,
		"crit_rate": 50,
		"attack_speed": 100,
		"equipped_artifacts" : [101, 102],
		"equipped_weapon": null
	},

	"Chara2": {
		"name": "Ikuyo Kita",
		"scene_path": "res://Player/Character2/Chara2.tscn",
		"texture": "res://Graphics/Player/Ikuyo_Kita_Character_Design_2.png",
		"weapon": "Sword",
		"current_status": "locked", #dead, alive, locked
		"hp": 100,
		"max_hp": 100,
		"damage": 10,
		"speed": 400,
		"crit_dmg": 150,
		"crit_rate": 50,
		"attack_speed": 100,
		"equipped_artifacts" : [101],
		"equipped_weapon": null
	}
}
