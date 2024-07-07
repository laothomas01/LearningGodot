"""
renable everything when coming back to this to complete homing missile skill 
"""

extends Node2D

@export var max_damage = 1
@export var max_cooldown = 0.1
@export var projectile_speed = 200
@onready var timer = get_node("Timer")
@onready var character = get_tree().get_first_node_in_group("character")
# Called when the node enters the scene tree for the first time.
func _ready():
	print('homing missile ability ready')
	timer.wait_time = max_cooldown	
	timer.start()
	
func _on_timer_timeout():
		var projectile = preload("res://TestScene3/Scenes/Abilities/Projectile.tscn").instantiate()
		projectile.set_type("HOMING")		
		add_child(projectile)
		projectile.move_speed = projectile_speed
		projectile.global_position = global_position
		projectile.damage = max_damage 
		
		#fire projectile in random direction and have projectile home in on nearest enemy 
		var viewport_size = get_viewport_rect().size
		var rand_x = randf_range(-viewport_size.x,viewport_size.x)
		var rand_y = randf_range(-viewport_size.y,viewport_size.y)
#		var direction = character.last_move_direction if character.last_move_direction != Vector2.ZERO else Vector2.RIGHT
		projectile.move_direction = (position-Vector2(rand_x,rand_y)).normalized()
		
		
