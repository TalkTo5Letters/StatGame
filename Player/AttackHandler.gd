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
	if Input.is_action_pressed("primary") && player_can_input:
		print("YUWI OAHA")
		attacking = true
		basic_attack()
	elif($"..".velocity.length() > 0 && attacking == false):
		state_machine.travel("BlendTree")
		print("tite")
	elif(attacking == false):
		state_machine.travel("Idle")



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
<<<<<<< Updated upstream
=======

func charged_attack():
	attacking = true
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Special_Attacks_Charged_Attack")
	$"..".velocity = $"..".velocity.lerp(Vector2(1,0).rotated(get_angle_to(get_global_mouse_position())).normalized() * 400, 1) * 2 
	
func elemental_attack():
	pass

func burst_attack():
	pass

func check_basic_attack():
	if Input.is_action_just_pressed("primary") && player_can_input:
		$Charged_attack_timer.set_paused(false)
		$Charged_attack_timer.start(1)
		print($Charged_attack_timer.time_left)
		return true
	if Input.is_action_just_released("primary") && player_can_input:
		$Charged_attack_timer.set_paused(true)
		if $Charged_attack_timer.time_left > 0 && $Charged_attack_timer.time_left < 1:
			print($Charged_attack_timer.time_left)
			basic_attack()
			return true
	else:
		return false
	
func _on_charged_attack_timer_timeout():
	charged_attack()
>>>>>>> Stashed changes
