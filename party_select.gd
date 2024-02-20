extends Control
var unlocked_characters
var locked_characters
var current_slot

func _input(event):
	if event.is_action_pressed("escape"):
		close()
	
func _ready():
	for i in unlocked_characters:
		var characterbutton = preload("res://Player/Party/character_button.tscn").instantiate()
		characterbutton.character = i
		characterbutton.current_slot = current_slot
		characterbutton.status = "unlocked"
		$ScrollContainer/GridContainer.add_child(characterbutton)
	for i in unlocked_characters:
		var characterbutton = preload("res://Player/Party/character_button.tscn").instantiate()
		characterbutton.character = i
		characterbutton.current_slot = current_slot
		characterbutton.status = "locked"
		$ScrollContainer/GridContainer.add_child(characterbutton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close():
	var party_control = load("res://party_control.tscn").instantiate()
	add_sibling(party_control)
	queue_free()

