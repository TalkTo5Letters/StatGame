extends Node2D
var player_can_input
var attack_pressed
var animation_tree
var state_machine
var basic_attack_level 
@export var attacking = false
var charged_attacking = false
var state_machine_attacking


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $"../AnimationTree"
	state_machine = animation_tree.get("parameters/playback")
	state_machine_attacking = animation_tree.get("parameters/Attacking/playback")
	player_can_input = true
	attack_pressed = false
	basic_attack_level = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if charged_attacking:
		$"..".move_and_slide()


func start_charged_attack():
	charged_attacking = true
	
func stop_charged_attack():
	charged_attacking = false

func can_attack():
	player_can_input = true

func cant_attack():
	player_can_input = false

func attack_done():
	basic_attack_level = 0
	player_can_input = true
	attacking = false

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
	player_can_input = false
	attacking = true
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack1")
	
	
func basic_attack2():
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack2")
	player_can_input = false
	
func basic_attack3():
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack3")
	player_can_input = false

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
		if $Charged_attack_timer.is_paused():
			$Charged_attack_timer.set_paused(false)
			$Charged_attack_timer.start(1)
			print($Charged_attack_timer.time_left)
			return false
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
