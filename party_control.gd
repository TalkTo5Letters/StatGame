extends Control
var Party
var Character1
var Character2
var Character3 
var Character4
var locked_charas
var unlocked_charas
# Called when the node enters the scene tree for the first time.
func _ready():
	Party = PartyList.party
	Character1 = Party[0]
	Character2 = Party[1]
	Character3 = Party[2]
	Character4 = Party[3]
	locked_charas = []
	unlocked_charas = []
	load_screen(Party)
	get_characters()
	print(locked_charas)
	print(unlocked_charas)

func _input(event):
	if event.is_action_pressed("escape"):
		close()
	
func close():
	var party_menu = load("res://Player/Party/party_menu.tscn").instantiate()
	party_menu.is_open = true
	party_menu.visible = true
	add_sibling(party_menu)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_character_1_pressed():
	open_charac_change_screen(0)


func _on_character_2_pressed():
	open_charac_change_screen(1)


func _on_character_3_pressed():
	open_charac_change_screen(2)

func _on_character_4_pressed():
	open_charac_change_screen(3)

func open_charac_change_screen(chosen_character_slot):
	var character_slot = chosen_character_slot
	var party_select = preload("res://party_select.tscn").instantiate()
	party_select.current_slot = character_slot
	party_select.unlocked_characters = unlocked_charas
	party_select.locked_characters = locked_charas
	add_sibling(party_select)
	queue_free()
	
func load_screen(Party):
	var slot = 0
	for i in Party:
		if i != "empty":
			match slot:
				0:
					$Character1/TextureRect.texture = load(CharacterStats.Characters.get(i).get("texture"))
				1:
					$Character2/TextureRect.texture = load(CharacterStats.Characters.get(i).get("texture"))
				2:
					$Character3/TextureRect.texture = load(CharacterStats.Characters.get(i).get("texture"))
				3:
					$Character4/TextureRect.texture = load(CharacterStats.Characters.get(i).get("texture"))
		slot += 1

func get_characters():
	for i in CharacterStats.Characters:
		if CharacterStats.Characters.get(i).get(CharacterStats.Characters) == "locked":
			locked_charas.append(i)
		else:
			unlocked_charas.append(i)
