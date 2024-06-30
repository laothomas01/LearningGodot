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
	timer.wait_time = max_cooldown
	timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
##	print(character.move_direction.length_squared())
#	if character.move_direction.length_squared() > 0:
#		var last_direction = character.move_direction
#
	pass
#	var current_direction = character.move_direction
#	if current_direction.x != 0:
#		projectile_move_direction.x = current_direction.x 
#
#	if current_direction.y != 0:
#		projectile_move_direction.y = current_direction.y
#	if current_direction.length_squared() > 0:
#		projectile_move_direction = current_direction
	# send information to skills that need information from player 
	#	if character.move_direction
#	#		current_move_direction = character.move_direction
#		if character.move_direction.x != 0:
#			current_move_direction.x = character.move_direction.x
#		else:
#			current_move_direction.x = 0
#		if character.move_direction.y != 0:
#			current_move_direction.y = character.move_direction.y
#		else:
#			current_move_direction.y = 0
		
	
func _on_timer_timeout():
#		var current_damage = max_damage
#
#		if character.in_rage_mode:
#			current_damage += (current_damage * character.rage_mode_damage_bonus)
#
#		if character.is_weakened:
#			current_damage -= (current_damage * character.weaken_amount)
#
		var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
		add_child(projectile)
		projectile.move_speed = projectile_speed
		projectile.global_position = global_position
		var direction = character.last_move_direction if character.last_move_direction != Vector2.ZERO else Vector2.RIGHT
		projectile.move_direction = direction 
		projectile.piercing_charges = piercing_charges
		projectile.set_type("PIERCING")
		
		
		
