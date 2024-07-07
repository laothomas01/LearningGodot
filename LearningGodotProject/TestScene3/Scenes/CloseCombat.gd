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

func _ready():
	print('slash ability ready!')
	timer.wait_time = max_cooldown
	timer.start()
	
func _process(delta):
	if character.activate_ragemode:
		var new_maxcooldown = max_cooldown - (max_cooldown * character.ragemode_attackspeed_bonus)
		timer.wait_time = new_maxcooldown
	else:
		timer.wait_time = max_cooldown
		
		
#@TODO 
func upgrade():
	pass
	
func set_max_cooldown(cooldown):
	max_cooldown = cooldown
func set_max_damage(damage):
	max_damage = damage

func _on_attack_timer_timeout():
	
		var melee = preload("res://TestScene3/Scenes/Abilities/Melee.tscn").instantiate()
		add_child(melee)
		if character.activate_ragemode:
			melee.set_damage(max_damage + (max_damage * character.ragemode_damage_bonus))
		else:
			melee.set_damage(max_damage)
		
		"""
		
		if any other debuffs applied to player,apply them here
		
		"""
		melee.set_pos(character.global_position + Vector2(40 * character.transform2D.scale.x,0))
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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
			
		
		
		
		
