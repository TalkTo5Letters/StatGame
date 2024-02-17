extends Node2D
var player_can_input
var attack_pressed
var animation_tree
var state_machine
var basic_attack_level
var attacking
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $"../AnimationTree"
	state_machine = animation_tree.get("parameters/playback")
	player_can_input = true
	attack_pressed = false
	attacking = false
	basic_attack_level = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func can_attack():
	print("can now attack")
	player_can_input = true

func cant_attack():
	player_can_input = false

func attack_done():
	print("gyahaha")
	basic_attack_level = 0
	player_can_input = true
	attacking = false
	state_machine.travel("Idle")

func basic_attack():
	basic_attack_level += 1
	print(basic_attack_level)
	match basic_attack_level:
		1:
			basic_attack1()
		2:
			basic_attack2()
		3:
			basic_attack3()
	


func basic_attack1():

	print("Attack")
	state_machine.travel("Attacking")
	player_can_input = false
	
func basic_attack2():
	var state_playback = $"../AnimationTree".get("parameters/Attacking/playback")
	print("Attack")
	state_playback.travel("Basic_Attack_Attack2")
	player_can_input = false
	
func basic_attack3():
	var state_playback = $"../AnimationTree".get("parameters/Attacking/playback")
	print("Attack")
	state_playback.travel("Basic_Attack_Attack3")
	player_can_input = false
