extends Node2D

"""
Howl:
	- a non-targetting ranged ability
	- generate a projectile that moves in the direction the player is facing 
	- pierces enemies
	- 4 directions  
"""
@export var max_damage = 1
#we have not incorporated this yet 
@export var piercing_charges = 2
@export var max_cooldown = 1
@export var projectile_speed = 200
@onready var timer = get_node("Timer")
@onready var character = get_tree().get_first_node_in_group("character")
var projectile_move_direction

func _ready():
	projectile_move_direction = Vector2.RIGHT
	print('howl ability ready ')
	print('initial wait time:',timer.wait_time)
	
	timer.start()
	
func _process(delta):
	if character.activate_ragemode:
		print('activate rage mode')
		timer.wait_time = max_cooldown * character.ragemode_attackspeed_bonus
	else:
		timer.wait_time = max_cooldown
		
##		timer.wait_time = 0
#
##		var new_maxcooldown = max_cooldown - (max_cooldown * character.ragemode_attackspeed_bonus)
##		print('new maxcooldown:', new_maxcooldown)
##		timer.wait_time = new_maxcooldown
##		print('rage mode activated: current wait time:',timer.wait_time)
#
#	else:
#		timer.wait_time = max_cooldown
		
#		timer.wait_time = max_cooldown
		
func _on_timer_timeout():
	
		var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
		projectile.set_type("PIERCING")		
		add_child(projectile)
		projectile.set_speed(projectile_speed)
		projectile.set_pos(global_position)
		if character.activate_ragemode:
			projectile.set_damage(max_damage + (max_damage * character.ragemode_damage_bonus))
		else:
			projectile.set_damage(max_damage)
		
		var direction = character.last_move_direction if character.last_move_direction != Vector2.ZERO else Vector2.RIGHT
		projectile.move_direction = direction 
		projectile.piercing_charges = piercing_charges

		
		
		
