extends Control
var is_open: bool
func _ready():
	update_party()
	
func _input(event):
	if event.is_action_pressed("party") && is_open != true:
		open()
	if event.is_action_pressed("escape")  && is_open != false:
		close()

func open():
	is_open = true
	get_tree().paused = true
	visible = true
	
func close():
	get_tree().paused = false
	is_open = false
	visible = false


func open_party_control():
	var party_control = preload("res://party_control.tscn").instantiate()
	add_sibling(party_control)
	queue_free()

func update_party():
	$"../../Party".update_bar()
	$"../../Party".switch_characters()


func _on_button_5_pressed():
	open_party_control()
