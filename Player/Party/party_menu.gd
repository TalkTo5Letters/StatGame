extends Control
var is_open 

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
