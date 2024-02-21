extends Node2D
var party
var current_chara_index
var current_character
# Called when the node enters the scene tree for the first time.
func _ready():
	current_chara_index = 0
	load_party()
	update_current_character()
		
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
			if party.find(i) == current_chara_index && (i != party[current_chara_index] || current_character == null):
				current_character = load(character_scene_path).instantiate()
				$Player.add_child(current_character)
				
	update_bar()

func check_character_switch() -> bool:
	if Input.is_action_just_pressed("Character1"):
		print("Character1")
		if party[1] != "empty":
			current_chara_index = 0
			return true
		else: 
			return false
			
	elif Input.is_action_just_pressed("Character2"):
		print("Character2")
		if party[1] != "empty":
			current_chara_index = 1
			return true
		else: 
			return false
		
	elif Input.is_action_just_pressed("Character3"):
		print("Character3")
		if party[2] != "empty":
			current_chara_index = 2
			return true
		else: 
			return false
	elif Input.is_action_just_pressed("Character4"):
		print("Character4")
		if party[3] != "empty":
			current_chara_index = 3
			return true
		else: 
			return false
	else:
		return false

func switch_characters():
	print(current_character.position)
	PartyList.current_player_pos = current_character.position
	for i in party:
		if i != "empty":
			var character_scene_path = CharacterStats.Characters.get(i).get("scene_path")
			if party.find(i) == current_chara_index:
				current_character.queue_free()
				current_character = load(character_scene_path).instantiate()
				current_character.position = PartyList.current_player_pos
				$Player.add_child(current_character)
				update_current_character()

func update_bar():
	$CanvasLayer/Control/CharacterGrid.add_charac_to_bar(party)

func update_current_character():
	PartyList.current_player_node = get_node(current_character.get_path())
	pass


func _on_slime_spawner_timeout():
	pass # Replace with function body.
