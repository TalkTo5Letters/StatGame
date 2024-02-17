extends GridContainer
var current_category = "weapons"
var weapon_data
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_inv():
	match current_category:
		"weapons":
			for i in InventoryList.Weapons:
				var weapon_inv = preload("res://Player/weapon_slot_inv.tscn").instantiate()
				weapon_inv.weapon_data = GlobalItemList.Weapons.get(i)
				add_child(weapon_inv)

func clear_inv():
	for n in get_children():
		n.queue_free() 
