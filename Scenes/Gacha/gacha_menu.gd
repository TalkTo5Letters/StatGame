extends Control
var is_gacha_open
var is_in_result
var cant_close
var animation_playing
var rng 

func _input(event):
	if event.is_action_pressed("gacha") && is_gacha_open != true:
		open()
	if event.is_action_pressed("escape")  && is_gacha_open != false:
		close()
	if event.is_action_pressed("primary") && animation_playing:
		$VideoStreamPlayer.stop()
		_on_video_stream_player_finished()
		

func open():
	is_gacha_open = true
	get_tree().paused = true
	visible = true
	
func close():
	if is_in_result && animation_playing == false:
		end_gacha_result()
	else:
		get_tree().paused = false
		is_gacha_open = false
		visible = false




func generate_class():
	rng = RandomNumberGenerator.new()
	var item_class
	var class_probability =  rng.randi_range(1, 100)
	if class_probability > 30:
		item_class = "consumable"
	elif class_probability <= 30 && class_probability > 1:
		item_class = "weapon"
	elif class_probability <= 30 && class_probability > 1:
		item_class = "weapon"
	return item_class
	
func generate_character():
	rng = RandomNumberGenerator.new()
	var possible_characters = 0
	var locked_characters = []
	for i in CharacterStats.Characters:
		if CharacterStats.Characters.get(i).get("current_status") == "locked":
			possible_characters += 1
			locked_characters.append(i)
	if possible_characters == 0:
		return false
	var character_index = rng.randi_range(0, possible_characters - 1)
	print(locked_characters[character_index])
	CharacterStats.Characters.get(locked_characters[character_index])["current_status"] = "alive"
	var character_button = preload("res://Scenes/Gacha/character_button.tscn").instantiate()
	character_button.character = locked_characters[character_index]
	$GachaResult/GridContainer.add_child(character_button)
	return true


func _on_roll_pressed():
	generate_character()
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
	
func end_gacha_result():
	cant_close = false
	$FadeIn.visible = false
	$GachaScreen.visible = true
	$GachaResult.visible = false
	is_in_result = false
