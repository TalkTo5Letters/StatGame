extends CharacterBody2D
var animation_player
var animation_tree
var state_machine
var input_direction
var player_sprite

var hp
var damage
var speed
var crit_dmg
var crit_rate
var attack_speed
var is_attacking

@export var friction = 0.2
@export var acceleration = 0.5
@export var sprint = 1.2

func _ready():
	animation_player = $AnimationPlayer
	animation_tree = $AnimationTree
	player_sprite = $Sprite2D
	state_machine = animation_tree.get("parameters/playback")
	animation_tree["active"] = true
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
	if Input.is_action_pressed("primary") && $AttackHandler.player_can_input:
		print("YUWI OAHA")
		$AttackHandler.attacking = true
		$AttackHandler.basic_attack()
	elif $AttackHandler.attacking == false:
		get_input()
		movement()

func update_animation_parameters(move_input : Vector2, sprint: bool):
	if move_input.length() > 0:
		if sprint:
			animation_tree.set("parameters/Walk/TimeScale/scale", 2)
			state_machine.travel("Walk")
		else:
			animation_tree.set("parameters/Walk/TimeScale/scale", 1)
			state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
	

	if move_input.x > 0:
			player_sprite["flip_h"] = true
	if move_input.x < 0:
			player_sprite["flip_h"] = false
	
	if move_input.y < 0:
		animation_tree["parameters/Walk/walking/conditions/facing_up"] = true
		animation_tree["parameters/Walk/walking/conditions/facing_down"] = false
	else:
		animation_tree["parameters/Walk/walking/conditions/facing_up"] = false
		animation_tree["parameters/Walk/walking/conditions/facing_down"] = true
		

func reload_stats():
	hp = CharacterStats.Chara1.get("hp")
	damage = CharacterStats.Chara1.get("damage")
	speed = CharacterStats.Chara1.get("speed")
	crit_dmg = CharacterStats.Chara1.get("crit_dmg")
	crit_rate = CharacterStats.Chara1.get("crit_rate")
	attack_speed = CharacterStats.Chara1.get("attack_speed")
	
	if CharacterStats.Chara1.get("equipped_weapon").is_empty():
		CharacterStats.Chara1["equipped_weapon"] = 1
		var equipped_weapon = GlobalItemList.Weapons.get(CharacterStats.Chara1.get("equipped_weapon"))
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
				
	if CharacterStats.Chara1.get("equipped_artifacts").is_empty() == false:
		for equipped_artifact_id in CharacterStats.Chara1.get("equipped_artifacts"):
			var equipped_artifact = GlobalItemList.Artifacts.get(equipped_artifact_id)
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
