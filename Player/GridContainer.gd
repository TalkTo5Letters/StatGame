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
				var weapon_inv = preload("res://Player/Inventory/Weapons/weapon_slot_inv.tscn").instantiate()
				print(GlobalItemList.Weapons.get(i))
				weapon_inv.weapon_data = GlobalItemList.Weapons.get(i)
				add_child(weapon_inv)
		"artifacts":
			for i in InventoryList.Artifacts:
				var artifact_inv = preload("res://Player/Inventory/Artifacts/artifact_slot_inv.tscn").instantiate()
				artifact_inv.artifact_data = GlobalItemList.Artifacts.get(i)
				add_child(artifact_inv)
		"consumables":
			for i in InventoryList.Consumables:
				var consumable_inv = preload("res://Player/Inventory/Consumables/consumables_slot_inv.tscn").instantiate()
				consumable_inv.consumable_data = GlobalItemList.Consumables.get(i)
				add_child(consumable_inv)

func clear_inv():
	for n in get_children():
		n.queue_free() 


func _on_weapon_pressed():
	clear_inv()
	current_category = "weapons"
	load_inv()


func _on_artifacts_pressed():
	clear_inv()
	current_category = "artifacts"
	load_inv()


func _on_consumables_pressed():
	clear_inv()
	current_category = "consumables"
	load_inv()
