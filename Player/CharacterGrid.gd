extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_charac_to_bar(party):
	for i in party:
		if i != "empty":
			var character_bar = preload("res://Player/Party/character_bar.tscn").instantiate()
			character_bar.character_id = i
			add_child(character_bar)
