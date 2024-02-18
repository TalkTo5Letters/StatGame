extends Node2D
var party

# Called when the node enters the scene tree for the first time.
func _ready():
	load_party()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_party():
	party = PartyList.party
	if party[0] == "empty" && party[1] == "empty" && party[2] == "empty" && party[3] == "empty" :
		PartyList.party[0] = "Chara1"
		party = PartyList.party
		print(party)
	for i in party:
		if i != "empty":
			var character_scene_path = CharacterStats.Characters.get(i).get("scene_path")
			print(character_scene_path)
			var character_scene = load(character_scene_path).instantiate()
			add_child(character_scene)
	$CanvasLayer/Control/CharacterGrid.add_charac_to_bar(party)
