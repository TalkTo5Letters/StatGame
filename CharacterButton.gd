extends Control
var character
var status
var current_slot 
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load(CharacterStats.Characters.get(character).get("texture"))
	if status == "locked":
		$ColorRect.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_pressed():
	print("Aaaaaaaaaaaaa")
	if PartyList.party.find(character) != -1 ||status == "locked":
		print("Character is in party or is locked")
		pass
	else:
		PartyList.party[current_slot] = character
		print("Character added in party")
