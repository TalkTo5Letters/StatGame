extends Control
var is_open 

func _input(event):
	if event.is_action_pressed("inventory") && is_open != true:
		open()
	if event.is_action_pressed("escape")  && is_open != false:
		close()

func open():
	is_open = true
	get_tree().paused = true
	$GridContainer.load_inv()
	visible = true
	
func close():
	$GridContainer.clear_inv()
	get_tree().paused = false
	is_open = false
	visible = false
