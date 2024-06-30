extends Node2D
"""
CloseCombat/Slash:
- generate a hit box offset from the player position and using a melee.tscn instance 
- performs area damage 
"""
@export var max_cooldown = 1
@export var max_damage = 1


@export var lifespan = 1
@onready var timer = get_node("Timer")
@onready var character = get_tree().get_first_node_in_group("character")
#var randomized_choices = ["max_damage","max_cooldown","double_slash","double_attack"]
var randomized_choices = ["max_damage","max_cooldown","double_slash"]

func _ready():
	print('close combat ability ready!')
	timer.wait_time = max_cooldown
	timer.start()
	
func _process(delta):
	pass
#	if character.in_rage_mode:
#		current_damage = max_damage + (max_damage * character.rage_mode_damage_bonus)
#	else:
#		current_damage = max_damage 
#
#	if character.
func upgrade():
	pass
#	var choice = randomized_choices.pick_random()
#	match choice:
#		"max_damage":
#			max_damage += 1
#		"max_cooldown":
#			max_cooldown -= max_cooldown * 0.1
#		"double_slash":
#			# if already have upgrade,just call upgrade again
#			if double_slash:
#				upgrade()
#			else:
#				double_slash = true


	"""
	handle rage_mode and weakened state here
	"""		
func _on_attack_timer_timeout():
		
		var current_damage = max_damage
		
		if character.in_rage_mode:
			current_damage += (current_damage * character.rage_mode_damage_bonus)
			
		if character.is_weakened:
			current_damage -= (current_damage * character.weaken_amount)
		
		var melee = preload("res://TestScene3/Scenes/Abilities/Melee.tscn").instantiate()
		add_child(melee)
		melee.global_position = character.global_position + Vector2(40 * character.transform2D.scale.x,0)
		
		
		
		
		
		
		
		
		
		
		
		
		
#		# set the state to ATTACK
#		if double_slash:
#			var melee = preload("res://TestScene3/Scenes/Abilities/Melee.tscn").instantiate()
#			add_child(melee)
#			melee.global_position = character.global_position + Vector2(40 * character.transform2D.scale.x,0)
#			var melee2 = preload("res://TestScene3/Scenes/Abilities/Melee.tscn").instantiate()
#			add_child(melee2)			
#			melee2.global_position = character.global_position + Vector2(40 * character.transform2D.scale.x * -1,0)
#
##		if double_attack:
##			var number_range = randi_range(1,10)
##			if number_range > 6:
##				timer.time_left = 0
#
#
#		else:
#			add_child(melee)
#			melee.global_position = character.global_position + Vector2(40 * character.transform2D.scale.x,0)
			
		
		
		
		
