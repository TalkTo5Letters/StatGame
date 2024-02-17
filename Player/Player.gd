extends CharacterBody2D
var animation_player
var animation_tree
var state_machine
var input_direction

var hp
var damage
var speed
var crit_dmg
var crit_rate
var attack_speed

func _ready():
	animation_player = $AnimationPlayer
	animation_tree = $AnimationTree
	state_machine = animation_tree.get("parameters/playback")
	update_animation_parameters(Vector2(0,1), false)
	reload_stats()
	
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	if Input.is_action_pressed("sprint"): 
		velocity *= 1.5
		move_and_slide()
		update_animation_parameters(velocity, true)
		#state_machine_state(velocity)

	else:
		move_and_slide()
		update_animation_parameters(velocity, false)
		#state_machine_state(velocity)

func update_animation_parameters(move_input : Vector2, sprint: bool):
	if(move_input != Vector2.ZERO):
		if sprint:
			animation_tree.set("parameters/BlendTree/TimeScale/scale", 2)
			animation_tree.set("parameters/Idle/blend_position", move_input)
			animation_tree.set("parameters/BlendTree/Walk/blend_position", move_input)
		else:
			animation_tree.set("parameters/BlendTree/TimeScale/scale", 1)
			animation_tree.set("parameters/Idle/blend_position", move_input)
			animation_tree.set("parameters/BlendTree/Walk/blend_position", move_input)

func state_machine_state(velocity):
	if(velocity != Vector2.ZERO):
		state_machine.travel("BlendTree")
	else:
		state_machine.travel("Idle")

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
