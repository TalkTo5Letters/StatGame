extends Control
var character = "Chara2"

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load(CharacterStats.Characters.get(character).get("texture"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
