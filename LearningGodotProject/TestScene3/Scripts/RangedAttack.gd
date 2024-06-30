extends Node2D



#################################



#"""
#will there be separate timers for different ranged_attack behaviors?
#
#- can we just combine behaviors? 
#	ex: 
#		multi shot = shoot multiple sepearated projectiles at enemy
#		spiral shot = shoot in a circular motion 
#
#		multishot + spiralshot = shoot multiple seperated projectile in a circular motion at enemy 
#
#
#""" 
#
###################################
#
#"""
#lifespan timer will be set to Autostart and Oneshot
#	- check the inspector of the timer
#"""
#@export var move_speed = 1
#@export var damage = 1


#var level = 0
#var target = Vector2.ZERO
#var trajectory = Vector2.ZERO
#var is_multi_shot= false
#var isPoisonShot = false 
#var is_spiral_shot = false



#var attack_behaviors = ["multi_shot","spiral_shot","explosive_shot","poison_shot"] 

#var ammo = 5
#var angle_offset = 15 # Degrees between each shot 
#var bullet_index = 0
#var initial_bullet_angle = 0

#var upgrades = {
#"multi_shot" : 0,
#"spiral_shot" :0,
#"poison_shot":0,
#"explosive_shot" : 0
#}
#
#var level = 1
#var target_position = Vector2.ZERO
#var initial_targetted_shoot_direction = Vector2.ZERO
#var initial_shoot_angle = 0
## currently for testing multi shoot 
#var ammo_count = 3
#var shoot_angle_offset = 15

#var target_position = Vector2.ZERO
#
#var initial_multi_shoot_direction = Vector2.ZERO
#var initial_multi_shoot_angle = 0
#var multi_shoot_bullet_count = 3
#var multi_shoot_angle_offset = 10
#
##var mul
#
#
## lets just have spiral shoot have no targetted position 
##var spiral_shoot_direction = Vector2.ZERO
#var initial_spiral_shoot_direction = Vector2.ZERO
#var initial_spiral_shoot_direction_angle = 0
#
#var initial_basic_var target_position = Vector2.ZERO

#var initial_multi_shoot_direction = Vector2.ZERO
#var initial_multi_shoot_angle = 0
#var multi_shoot_bullet_count = 3
#var multi_shoot_angle_offset = 10
#
##var mul
#
#
## lets just have spiral shoot have no targetted position 
##var spiral_shoot_direction = Vector2.ZERO
#var initial_spiral_shoot_direction = Vector2.ZERO
#var initial_spiral_shoot_direction_angle = 0
#
#var initial_basic_shoot_direction = Vector2.ZERO
#var initial_basic_shoot_direction_angle = 0
#shoot_direction = Vector2.ZERO
#var initial_basic_shoot_direction_angle = 0
#
#"""
#can add different attributes here that will be passed on 
#to created projectiles 
#"""
#@export var damage = 1
#@export var cooldown = 1
#@export var bulletspeed = 200

#var level = 1

"""
RANGED ATTACK BASE STATS 
"""
@export var damage = 1
@export var cooldown = 1
@export var projectile_speed = 200


@onready var timer = get_node("RangedAttackTimer")
@onready var character = get_tree().get_first_node_in_group("character")

"""
looks like we are sticking to branching upgrades for ranged attack
- either go multi shoot or spiral shoot 
"""
#var unlocked_upgrades = []
	

"""
will always be updated with a position 
"""
func _ready():
	print('Ranged Combat ready!')
	timer.wait_time = cooldown
	timer.start()
#	print(bulletspeed)
#	unlocked_upgrades.append("multi_shoot")
	
	
"""
for handling bonuses or reductions to the ability 
"""
func _process(delta):
	pass
#	if initial_spiral_shoot_direction_angle > 360:
#		initial_spiral_shoot_direction_angle -= 360
#
#func _update_target_position(detected_enemy_position):
#	pass
#	target_position = detected_enemy_position
func upgrade():
	pass
#	print('upgrading ranged attack')
#	level += 1
#	print("new level: ",level)
#	var randomized_choices = ["damage","cooldown"]
#	var choice = randomized_choices.pick_random()
#	match choice:
#		"damage":
#			print("damage")
#			damage += damage * 0.5
#		"cooldown":
#			print("cooldown")
#			cooldown -= cooldown * 0.5
#			timer.set_wait_time(cooldown)
#		"bulletspeed":
#			print("bulletspeed")
#			bulletspeed += bulletspeed * 0.5
##
"""
attacks will contain attributes that can be upgrades and distributed to objects that rely on such attributes 
"""
func _on_ranged_attack_timer_timeout():
		pass
#		# perform a multi shoot spiral shot
#	print("Ranged Attack timeout:",global_position)
#
#		# if have both, we will do a spiraling multi shoot 
#	if unlocked_upgrades.has("multi_shoot") and unlocked_upgrades.has("spiral_shoot"):
#		pass
#		# perform a multi shoot
##		pass
##		# perform a multi shoot
##
##	# spread shot?
##	# fence shot(no spread. straight column alignment shot) 
##	el
##

#	if unlocked_upgrades.has("spiral_shoot"):
#			var angle = deg_to_rad(initial_spiral_shoot_direction_angle)
#			initial_spiral_shoot_direction = Vector2(cos(angle),sin(angle))
#			var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
#			projectile.scale = Vector2(0.5,0.5)
#			projectile.global_position = global_position
#			projectile.update_direction(initial_spiral_shoot_direction)
#			projectile.damage = damage
#			projectile.move_speed = bulletspeed
#			add_child(projectile)
#			initial_spiral_shoot_direction_angle += 15
#
#	elif unlocked_upgrades.has("multi_shoot"):
#		for i in range(multi_shoot_bullet_count):
#			initial_multi_shoot_direction = global_position.direction_to(target_position).normalized()
#			var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
#			initial_multi_shoot_angle = initial_multi_shoot_direction.angle()
#			var new_angle = initial_multi_shoot_angle + deg_to_rad((i-(multi_shoot_bullet_count -1)/2.0) * multi_shoot_angle_offset)
#			projectile.global_position = global_position
#			var new_direction = Vector2(cos(new_angle),sin(new_angle))
#			projectile.update_direction(new_direction)
#			projectile.move_speed = bulletspeed
#			projectile.damage=damage
#			add_child(projectile)
#	else:
#			initial_basic_shoot_direction = global_position.direction_to(target_position).normalized()
#			var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
#			projectile.global_position = global_position
#			projectile.update_direction(initial_basic_shoot_direction)
#			projectile.damage = damage
#			projectile.move_speed = bulletspeed
#
#			add_child(projectile)			
		
#		var projectile = preload("res://TestScene3/Scenes/Projectile.tscn").instantiate()
#
#
			
			
#		print('multi_shoot')
#		# we are testing spread shot
#		"""
#		what do we mean/how can we envision a spread shot?? 
#
#		"""
#		for i in range(ammo_count):
#			initial_targetted_shoot_direction = global_position.direction_to(target_position).normalized()
#			var projectile = preload("res://TestScene3/Scenes/Projectile.tscn").instantiate()
#			var initial_angle = initial_targetted_shoot_direction.angle()
#			var new_angle = initial_angle + deg_to_rad((i-(ammo_count -1)/2.0) * shoot_angle_offset)
#			projectile.global_position = global_position
#			var new_direction = Vector2(cos(new_angle),sin(new_angle))
#			projectile._update_direction(new_direction)
#			add_child(projectile)
##		
#		# perform a spiral shoot
#
#	elif unlocked_upgrades.has("spiral_shoot"):
#		"""
#		if what we can do is take the CURRENT initial angle_value, and set it as the previous shoot angle 
#		"""
#
#		pass
#	else:
#		initial_targetted_shoot_direction = global_position.direction_to(target_position).normalized()
#		var projectile = preload("res://TestScene3/Scenes/Projectile.tscn").instantiate()
#		projectile.global_position = global_position
#		projectile._update_direction(initial_targetted_shoot_direction)
#		add_child(projectile)
