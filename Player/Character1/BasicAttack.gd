extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(get_angle_to(get_global_mouse_position()) - deg_to_rad(180))

func enable_collision():
	monitoring = true
	
func end_collision():
	monitoring = false
