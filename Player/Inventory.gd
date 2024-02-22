extends Control
var Inv_is_open = false

func _input(event):
	if event.is_action_pressed("inventory") && Inv_is_open != true:
		open()
	if event.is_action_pressed("escape")  && Inv_is_open != false:
		close()

func open():
	Inv_is_open = true
	get_tree().paused = true
	$ScrollContainer/GridContainer.load_inv()
	visible = true
	
func close():
	$ScrollContainer/GridContainer.clear_inv()
	get_tree().paused = false
	Inv_is_open = false
	visible = false
