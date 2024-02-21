extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_follow_area_body_entered(body):
	if body.is_in_group("Enemy"):
		pass


func _on_follow_area_body_exited(body):
	if body.is_in_group("Enemy"):
		body.attack_timer.stop()
		body.state = body.follow


func _on_attack_area_body_entered(body):
	if body.is_in_group("Enemy"):
		body.attack_timer.start()
		body.state = body.attack


func _on_attack_area_body_exited(body):
	if body.is_in_group("Enemy"):
		body.state = body.follow
