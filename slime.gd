extends CharacterBody2D
var target
var speed = 200
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = follow
var rng = RandomNumberGenerator.new()
var randomnum
var attack_timer
var animation_tree
var state_machine
var direction
var hp = 100

func _ready():
	$ProgressBar.value = hp
	animation_tree = $AnimationTree
	state_machine = animation_tree.get("parameters/playback")
	attack_timer = $AttackTimer
	rng.randomize()
	randomnum = rng.randf()
	var slime_type = rng.randi_range(0, 6)
	var slime_frame = [0]
	$AnimationPlayer.get_animation("Idle1").track_set_key_value(0, 0, 0 + (slime_type * 7))
	$AnimationPlayer.get_animation("Idle1").track_set_key_value(0, 1, 1 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 0, 0 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 1, 1 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 2, 2 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 3, 3 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 4, 4 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 5, 5 + (slime_type * 7))
	$AnimationPlayer.get_animation("Walking").track_set_key_value(0, 6, 6 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 0, 0 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 1, 1 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 2, 2 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 3, 3 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 4, 4 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 5, 5 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 6, 6 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 7, 7 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 8, 8 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 9, 9 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 10, 10 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 11, 11 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 12, 12 + (slime_type * 7))
	$AnimationPlayer.get_animation("Attack").track_set_key_value(0, 13, 13 + (slime_type * 7))
	

func _physics_process(delta):
	match state:
		follow:
			target = get_circle_position(randomnum)
			move(target, delta)
			state_machine.travel("Walking")
			$Idle1.visible = false
			$Attack.visible = false
			$Moving.visible = true
			if direction.x > 0:
				$Moving.flip_h = false
			if direction.x < 0:
				$Moving.flip_h = true
		attack:
			pass

enum {
	follow,
	attack,
	hit,
}

func move (target, delta):
	direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()
	
func get_circle_position(random):
	var kill_circle_centre = PartyList.current_player_node.position
	var radius = 80
	var angle = random * PI * 2
	var x = kill_circle_centre.x + cos(angle) * radius
	var y = kill_circle_centre.y + sin(angle) * radius
	return Vector2(x, y)

func attack_player():
	PartyList.current_player_node.take_damage(10)

func reset_timer():
	attack_timer.start()
	
func _on_attack_timer_timeout():
	print("Giyatt")
	$Idle1.visible = false
	$Attack.visible = true
	$Moving.visible = false
	if direction.x > 0:
		$Attack.flip_h = false
	if direction.x < 0:
		$Attack.flip_h = true
	state_machine.travel("Attack")

func attacked(damage):
	print("took" + str(damage) + " damage!")
	print(hp)
	hp -= damage
	$ProgressBar.value = hp
	$AnimationPlayer.play("damaged")
	if hp <= 0:
		queue_free()
