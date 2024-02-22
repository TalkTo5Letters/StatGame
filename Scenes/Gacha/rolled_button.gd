extends Control
var object_name = "Chara2"
var type
# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		"character":
			$TextureRect.texture = load(CharacterStats.Characters.get(object_name).get("texture"))
		"weapon":
			$TextureRect.texture = load(GlobalItemList.Weapons.get(object_name).get("texture"))
		"consumable":
			$TextureRect.texture = load(GlobalItemList.Consumables.get(object_name).get("texture"))
		"artifact":
			$TextureRect.texture = load(GlobalItemList.Artifacts.get(object_name).get("texture"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
