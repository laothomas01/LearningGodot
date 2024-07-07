extends CharacterBody2D

"""

basic slime 

[] fix the enemy spawn positions
[] make enemy spawning from boss cleaner #
#		if Input.is_action_just_pressed("Dash") && move_direction.length() > 0:
#			print('Dash')
#			_update_velocity(move_direction,move_speed * 10,delta)
#		else:
#			_update_velocity(move_direction,move_speed,delta)
	
"""



@export var movement_speed = 1
@export var damage = 3
#@onready var character = get_tree().get_first_node_in_group("character") 
@onready var animation = $TransformAdjustment/AnimatedSprite2D
@onready var hit_box = $HitBox
@onready var slime_spawn_timer = get_node("SpawnEnemyTimer")
@onready var character = get_tree().get_first_node_in_group("character") 
var max_enemy_spawn_count = 10
var enemy_spawn_count = 0
var hit_count = 0

var exp_gem = preload("res://TestScene3/Scenes/Gem.tscn")

enum {
	IDLE,
	WALK,
	DEATH,
	DAMAGE,
	SPAWN_SLIMES
}

var state: int = WALK:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			WALK:
				walk_state()
			DEATH:
				death_state()
			DAMAGE:
				damage_state()
			SPAWN_SLIMES:
				spawn_minions_state()
			
@export var maxhealth = 1.0
var health = 0
func _ready():
	health = maxhealth
	print('health:',health)
	hit_box.damage = damage
	state = WALK
#	state = SPAWN_SLIMES
	
#	slime_spawn_cooldown.start()
	
func _process(delta):
	
#	print(transform2D.global_position)
#	print(state)
	if state != DAMAGE and state != SPAWN_SLIMES:
				state = WALK if velocity.length_squared() > 0 else IDLE
	var move_direction = global_position.direction_to(character.global_position)
	velocity = move_direction * movement_speed * delta
	
	if state != SPAWN_SLIMES:
		move_and_slide()

func idle_state():
#	animation.play("IdleOrMove")
	pass
func walk_state():
#	print("walk state")
#	animation.play("Jump")
	animation.play("IdleOrMove")

func damage_state():
	if health <= 0:
		animation.play("Death")
		await animation.animation_finished
		state = DEATH
	else:
#		print("damage state")
		animation.play("TakeDamage")
		await animation.animation_finished
		state = WALK
#	if health <= 0:
#		pass
#	else:
#		animation.play("TakeDamage")
#		await animation.animation_finished
#		state = WALK

"""
do something when the entity dies 
ex: drop gems, explode, do something on death 

figure out how to create a death counter for player 

"""
func death_state():
	queue_free()
"""
might need an alternative to enums but this is how we will handle states for now 

"""



"""
callback function for taking damage signals 
"""

func _on_hurt_box_hurt(damage):
	print('damage',damage)
# ============================== 
# 	keep this block of code  
	health -= damage
	print(health)
	state = DAMAGE
	hit_count += 1
	
	if hit_count == 3:
		# allow enemy to be invulnerable??? 
		hit_count = 0
		state = SPAWN_SLIMES
		
# ===============================

func get_random_position():
	
	var offset_position = Vector2(150,150);
	var top_left = Vector2(global_position.x - offset_position.x,global_position.y - offset_position.y)
	var top_right = Vector2(global_position.x + offset_position.x,global_position.y - offset_position.y)
	var bottom_left = Vector2(global_position.x - offset_position.x,global_position.y + offset_position.y)
	var bottom_right = Vector2(global_position.x + offset_position.x,global_position.y + offset_position.y)
	
#
	var pos_side = ["top_left","top_right","bottom_left","bottom_right"].pick_random()
			
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO

	match pos_side:
		"top_left":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"top_right":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"bottom_left":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"bottom_right":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn,y_spawn)
	
func spawn_minions_state():
	animation.play("IdleOrMove")
	slime_spawn_timer.start()
	
#boss behavior 1
func spawn_minions():	
	if enemy_spawn_count == max_enemy_spawn_count:
		enemy_spawn_count = 0
		slime_spawn_timer.stop()
		state = WALK
	else:
		pass
#		enemy_spawn_count += 1
##		var enemy_spawn = preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn").instantiate()
#		enemy_spawn.position = get_random_position()
#		add_child(enemy_spawn)

func _on_spawn_enemy_timer_timeout():
	spawn_minions()
		
