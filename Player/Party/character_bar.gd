extends Control
var character_id
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.party_update.connect(on_party_update)
	on_party_update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_party_update():
	$CharacterName.text = CharacterStats.Characters.get(character_id).get("name")
	$ProgressBar.max_value = CharacterStats.Characters.get(character_id).get("max_hp")
	$ProgressBar.value = CharacterStats.Characters.get(character_id).get("hp")
