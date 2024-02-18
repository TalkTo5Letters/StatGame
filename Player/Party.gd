extends Node2D
var party
var current_chara_index
var current_character
# Called when the node enters the scene tree for the first time.
func _ready():
	current_chara_index = 0
	load_party()
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if check_character_switch():
		switch_characters()

func load_party():
	party = PartyList.party
	if party[0] == "empty" && party[1] == "empty" && party[2] == "empty" && party[3] == "empty" :
		PartyList.party[0] = "Chara1"
		party = PartyList.party
		print(party)
	for i in party:
		if i != "empty":
			print(i)
			var character_scene_path = CharacterStats.Characters.get(i).get("scene_path")
			if party.find(i) == current_chara_index:
				current_character = load(character_scene_path).instantiate()
				add_child(current_character)
	$CanvasLayer/Control/CharacterGrid.add_charac_to_bar(party)

func check_character_switch() -> bool:
	if Input.is_action_just_pressed("Character1"):
		print("Character1")
		if !party[1].is_empty():
			current_chara_index = 0
		return true
	elif Input.is_action_just_pressed("Character2"):
		if !party[1].is_empty():
			current_chara_index = 1
		print("Character2")
		return true
	elif Input.is_action_just_pressed("Character3"):
		if !party[2].is_empty():
			current_chara_index = 2
		print("Character3")
		return true
	elif Input.is_action_just_pressed("Character4"):
		if !party[3].is_empty():
			current_chara_index = 3
		print("Character4")
		return true
	else:
		return false

func switch_characters():
	print(current_character.position)
	PartyList.current_player_pos = current_character.position
	current_character.queue_free()
	for i in party:
		if i != "empty":
			print(i)
			var character_scene_path = CharacterStats.Characters.get(i).get("scene_path")
			if party.find(i) == current_chara_index:
				current_character = load(character_scene_path).instantiate()
				current_character.position = PartyList.current_player_pos
				add_child(current_character)
