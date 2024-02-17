extends Control
var is_open 

func _input(event):
	if event.is_action_pressed("inventory") && is_open != true:
		open()
	if event.is_action_pressed("escape")  && is_open != false:
		close()

func open():
	is_open = true
	$GridContainer.load_inv()
	visible = true
	
func close():
	$GridContainer.clear_inv()
	is_open = false
	visible = false
