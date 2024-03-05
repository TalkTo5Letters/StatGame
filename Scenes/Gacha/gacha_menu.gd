extends Control
var is_gacha_open
var is_in_result
var cant_close
var animation_playing
var rng 

func _input(event):
	if event.is_action_pressed("gacha") && is_gacha_open != true:
		open()
	if event.is_action_pressed("escape")  && is_gacha_open != false && cant_close == false:
		close()
	if event.is_action_pressed("primary") && animation_playing:
		$VideoStreamPlayer.stop()
		_on_video_stream_player_finished()
		

func open():
	$"../Control".visible = false
	is_gacha_open = true
	get_tree().paused = true
	visible = true
	
func close():
	$"../Control".visible = true
	if is_in_result && animation_playing == false:
		end_gacha_result()
	else:
		get_tree().paused = false
		is_gacha_open = false
		visible = false




func generate_class():
	var item_class
	while true:
		rng = RandomNumberGenerator.new()
		var class_probability =  rng.randi_range(1, 100)
		if class_probability > 50:
			item_class = "consumable"
			break
		elif class_probability <= 50 && class_probability > 20:
			item_class = "artifact"
			break
		elif class_probability <= 20 && class_probability > 1:
			item_class = "weapon"
			break
		elif class_probability == 1:
			item_class = "character"
			var possible_characters = 0
			for i in CharacterStats.Characters:
				if CharacterStats.Characters.get(i).get("current_status") == "locked":
					possible_characters += 1
			if possible_characters > 0:
				break
	return item_class
	
func generate_character():
	rng = RandomNumberGenerator.new()
	var possible_characters = 0
	var locked_characters = []
	for i in CharacterStats.Characters:
		if CharacterStats.Characters.get(i).get("current_status") == "locked":
			possible_characters += 1
			locked_characters.append(i)
	var character_index = rng.randi_range(0, possible_characters - 1)
	CharacterStats.Characters[locked_characters[character_index]]["current_status"] = "alive"
	var rolled_button = preload("res://Scenes/Gacha/rolled_button.tscn").instantiate()
	rolled_button.name = locked_characters[character_index]
	rolled_button.type = "character"
	$GachaResult/GridContainer.add_child(rolled_button)

func generate_artifact():
	rng = RandomNumberGenerator.new()
	var possible_artifacts = []
	for i in GlobalItemList.Artifacts:
		possible_artifacts.append(i)
	var artifact_index = rng.randi_range(0, possible_artifacts.size() - 1)
	print(possible_artifacts.size())
	var rolled_button = preload("res://Scenes/Gacha/rolled_button.tscn").instantiate()
	rolled_button.object_name = possible_artifacts[artifact_index]
	rolled_button.type = "artifact"
	InventoryList.Artifacts.append(possible_artifacts[artifact_index])
	$GachaResult/GridContainer.add_child(rolled_button)
	
func generate_consumable():
	rng = RandomNumberGenerator.new()
	var possible_consumable = []
	for i in GlobalItemList.Consumables:
		possible_consumable.append(i)
	var consumable_index = rng.randi_range(0, possible_consumable.size() - 1)
	print(possible_consumable.size())
	var rolled_button = preload("res://Scenes/Gacha/rolled_button.tscn").instantiate()
	rolled_button.object_name = possible_consumable[consumable_index]
	rolled_button.type = "consumable"
	InventoryList.Consumables.append(possible_consumable[consumable_index])
	$GachaResult/GridContainer.add_child(rolled_button)
	
func generate_weapon():
	rng = RandomNumberGenerator.new()
	var possible_weapon = []
	for i in GlobalItemList.Weapons:
		possible_weapon.append(i)
	var weapon_index = rng.randi_range(0, possible_weapon.size() - 1)
	print(possible_weapon.size())
	var rolled_button = preload("res://Scenes/Gacha/rolled_button.tscn").instantiate()
	rolled_button.object_name = possible_weapon[weapon_index]
	rolled_button.type = "weapon"
	InventoryList.Weapons.append(possible_weapon[weapon_index])
	$GachaResult/GridContainer.add_child(rolled_button)

func _on_roll_pressed():
	var types_array = []
	for i in 1:
		var rolled_class = generate_class()
		types_array.append(rolled_class)
	for i in types_array:
		match i:
			"consumable":
				generate_consumable()
			"artifact":
				generate_artifact()
			"weapon":
				generate_weapon()
			"character":
				generate_character()
	print(types_array)
	roll_animation(1)


func roll_animation(number_of_rolls):
	cant_close = true
	animation_playing = true
	$GachaScreen.visible = false
	$GachaResult.visible = true
	is_in_result = true
	$GachaResult/GridContainer.columns = number_of_rolls
	$VideoStreamPlayer.visible = true
	$VideoStreamPlayer.play()
	
func _on_video_stream_player_finished():
	$VideoStreamPlayer.visible = false
	$FadeIn.visible = true
	$AnimationPlayer.play("Fade_in")
	animation_playing = false
	cant_close = false
	
func end_gacha_result():
	$FadeIn.visible = false
	$GachaScreen.visible = true
	$GachaResult.visible = false
	is_in_result = false
	for n in $GachaResult/GridContainer.get_children():
			n.queue_free() 


func _on_five_roll_pressed():
	var types_array = []
	for i in 5:
		var rolled_class = generate_class()
		types_array.append(rolled_class)
	for i in types_array:
		match i:
			"consumable":
				generate_consumable()
			"artifact":
				generate_artifact()
			"weapon":
				generate_weapon()
			"character":
				generate_character()
	print(types_array)
	roll_animation(5)
