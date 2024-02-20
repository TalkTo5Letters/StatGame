extends CharacterBody2D
var animation_player
var animation_tree
var state_machine
var input_direction
var player_sprite
var mouse_angle

var hp
var damage
var speed
var crit_dmg
var crit_rate
var attack_speed
var is_attacking
var CharacterStats
var character_name

@export var friction = 0.2
@export var acceleration = 0.5
@export var sprint = 1.2

func _ready():
	animation_player = $AnimationPlayer
	animation_tree = $AnimationTree
	player_sprite = $Player_Sprite
	state_machine = animation_tree.get("parameters/playback")
	animation_tree["active"] = true
	CharacterStats = get_node("/root/CharacterStats")
	update_animation_parameters(Vector2(0,1), false)
	reload_stats()
	
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction

func movement():
	var direction = get_input()
	update_animation_parameters(direction, false)
	if direction.length() > 0:
		if Input.is_action_pressed("sprint"):
			velocity = velocity.lerp(direction.normalized() * speed, acceleration) * sprint
			update_animation_parameters(direction, true)
		else:
			velocity = velocity.lerp(direction.normalized() * speed, acceleration) 
			update_animation_parameters(direction, false)
	else:
		update_animation_parameters(direction, false)
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	
func _physics_process(delta):
	if $AttackHandler.check_basic_attack() == false && $AttackHandler.attacking == false:
		get_input()
		movement()

func update_animation_parameters(move_input : Vector2, sprint: bool):
	var mouse_position = get_global_mouse_position()
	var mouse_angle = rad_to_deg(get_angle_to(mouse_position))
	if move_input.length() > 0:
		if sprint:
			animation_tree.set("parameters/Walk/TimeScale/scale", 2)
			state_machine.travel("Walk")
		else:
			animation_tree.set("parameters/Walk/TimeScale/scale", 1)
			state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
	
	print(mouse_angle)
	if (mouse_angle > 90 and mouse_angle < 180) or (mouse_angle > -180 and mouse_angle < -90):
		$weapon_horizontality["scale"] = Vector2(1,1)
	else:
		$weapon_horizontality["scale"] = Vector2(-1,1)
		
	if move_input.x > 0:
			player_sprite["scale"] = Vector2(-1,1)
	if move_input.x < 0:
			player_sprite["scale"] = Vector2(1,1)

	if move_input.y < 0 || (mouse_angle >= -170 and mouse_angle <= -10):
		animation_tree["parameters/Walk/walking/conditions/facing_up"] = true
		animation_tree["parameters/Walk/walking/conditions/facing_down"] = false
		animation_tree["parameters/Idle/conditions/facing_down"] = false
		animation_tree["parameters/Idle/conditions/facing_up"] = true
		$weapon_horizontality["z_index"] = -1
	else:
		animation_tree["parameters/Walk/walking/conditions/facing_up"] = false
		animation_tree["parameters/Walk/walking/conditions/facing_down"] = true
		animation_tree["parameters/Idle/conditions/facing_down"] = true
		animation_tree["parameters/Idle/conditions/facing_up"] = false
		$weapon_horizontality["z_index"] = 0
		

func reload_stats():
	hp = CharacterStats.Characters.get("Chara1").get("hp")
	damage = CharacterStats.Characters.get("Chara1").get("damage")
	speed = CharacterStats.Characters.get("Chara1").get("speed")
	crit_dmg = CharacterStats.Characters.get("Chara1").get("crit_dmg")
	crit_rate =CharacterStats.Characters.get("Chara1").get("crit_rate")
	attack_speed = CharacterStats.Characters.get("Chara1").get("attack_speed")
	
	if CharacterStats.Characters.get("Chara1").get("equipped_weapon") == null:
		CharacterStats.Characters.get("Chara1")["equipped_weapon"] = 1
		var equipped_weapon = GlobalItemList.Weapons.get(CharacterStats.Characters.get("Chara1").get("equipped_weapon")).get("effects")
		if equipped_weapon.has("hp"):
			hp += equipped_weapon.get("hp")
		if equipped_weapon.has("damage"):
			damage += equipped_weapon.get("damage")
		if equipped_weapon.has("speed"):
			speed += equipped_weapon.get("speed")
		if equipped_weapon.has("crit_dmg"):
			crit_dmg += equipped_weapon.get("crit_dmg")
		if equipped_weapon.has("crit_rate"):
			crit_rate += equipped_weapon.get("crit_rate")
		if equipped_weapon.has("attack_speed"):
			attack_speed += equipped_weapon.get("attack_speed")
				
	if CharacterStats.Characters.get("Chara1").get("equipped_artifacts").is_empty() == false:
		for equipped_artifact_id in CharacterStats.Characters.get("Chara1").get("equipped_artifacts"):
			var equipped_artifact = GlobalItemList.Artifacts.get(equipped_artifact_id).get("effects")
			if equipped_artifact.has("hp"):
				hp += equipped_artifact.get("hp")
			if equipped_artifact.has("damage"):
				damage += equipped_artifact.get("damage")
			if equipped_artifact.has("speed"):
				speed += equipped_artifact.get("speed")
			if equipped_artifact.has("crit_dmg"):
				crit_dmg += equipped_artifact.get("crit_dmg")
			if equipped_artifact.has("crit_rate"):
				crit_rate += equipped_artifact.get("crit_rate")
			if equipped_artifact.has("attack_speed"):
				attack_speed += equipped_artifact.get("attack_speed")
			
	print(hp)
	print(damage)
	print(speed)
	print(crit_dmg)
	print(crit_rate)
	print(attack_speed)
