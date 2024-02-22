extends Node2D
@export var damage_multiplier = 1.0
var damage
var player_can_input
var attack_pressed
var animation_tree
var state_machine
var basic_attack_level 
var attacking
var charged_attacking = false
var state_machine_attacking
var attack_friction :bool
var attack_friction_distance :float
var attack_velocity :Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree = $"../AnimationTree"
	state_machine = animation_tree.get("parameters/playback")
	state_machine_attacking = animation_tree.get("parameters/Attacking/playback")
	attacking = false
	attack_friction = false
	player_can_input = true
	attack_pressed = false
	$Charged_attack_timer.set_paused(true)
	basic_attack_level = 0
	reload_stats()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if charged_attacking:
		$"..".move_and_slide()
		

func start_charged_attack():
	player_can_input = false
	charged_attacking = true
	
func stop_charged_attack():
	if !Input.is_action_pressed("primary"):
		$Charged_attack_timer.set_paused(true)
	$Charged_attack_timer.set_paused(true)
	charged_attacking = false

func can_attack():
	player_can_input = true

func cant_attack():
	if !Input.is_action_pressed("primary"):
		$Charged_attack_timer.set_paused(true)
		player_can_input = false
	elif Input.is_action_pressed("primary"):
		player_can_input = true

func attack_done():
	print($Charged_attack_timer.time_left)
	$"..".velocity = Vector2(0,0)
	if !Input.is_action_pressed("primary"):
		$Charged_attack_timer.set_paused(true)
	player_can_input = true
	basic_attack_level = 0
	attacking = false

func basic_attack():
	$Charged_attack_timer.set_paused(false)
	$Charged_attack_timer.start(0.2)
	print($Charged_attack_timer.time_left)
	basic_attack_level += 1
	match basic_attack_level:
		1:
			basic_attack1()
		2:
			basic_attack2()
		3:
			basic_attack3()
		_:
			pass


func basic_attack1():
	$Charged_attack_timer.set_paused(true)
	player_can_input = false
	attacking = true
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack1")
	
	
func basic_attack2():
	$Charged_attack_timer.set_paused(true)
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack2")
	player_can_input = false
	
func basic_attack3():
	$Charged_attack_timer.set_paused(true)
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Basic_Attack_Attack3")
	player_can_input = false

func charged_attack():
	print("Gyahaha")
	attacking = true
	state_machine.travel("Attacking")
	state_machine_attacking.travel("Special_Attacks_Charged_Attack")
	$"..".velocity = $"..".velocity.lerp(Vector2(1,0).rotated(get_angle_to(get_global_mouse_position())).normalized() * 400, 1) * 2 
	
func elemental_attack():
	pass

func burst_attack():
	pass

func check_basic_attack():
	if Input.is_action_pressed("primary") && player_can_input:
		if $Charged_attack_timer.is_paused():
			$Charged_attack_timer.set_paused(false)
			$Charged_attack_timer.start(0.2)
			return false
	if Input.is_action_just_released("primary") && player_can_input:
		print($Charged_attack_timer.time_left)
		$Charged_attack_timer.set_paused(true)
		if $Charged_attack_timer.time_left > 0 && $Charged_attack_timer.time_left < .5:
			basic_attack()
			return true
	else:
		return false

func attack_friction_dynamics(attack_friction :bool, attack_friction_distance :float):
	if attack_friction == true:
		$"..".velocity = ($"..".velocity.lerp(Vector2(1,0).rotated(get_angle_to(get_global_mouse_position())).normalized(), 1)) * attack_friction_distance
		$"..".velocity = $"..".velocity
		print($"..".velocity)
		$"..".move_and_slide()
	
func _on_charged_attack_timer_timeout():
	charged_attack()


func _on_basic_attack_body_entered(body):
	print("Gya")
	if body.is_in_group("Enemy"):
		body.attacked(damage_multiplier * damage)
		body.attack_timer.start()

		
func reload_stats():
	damage = CharacterStats.Characters.get("Chara1").get("damage")
	
