extends Node2D

@export var max_cooldown = 1
@onready var timer = get_node("Timer")
@onready var character = get_tree().get_first_node_in_group("character")
@export var max_rotation_speed = 100
@export var max_laser_lifespan_duration = 3
var	max_laser_damage = 1

func _ready():
	print('laser eyes ability ready')
	timer.wait_time = max_cooldown	
	timer.start()

func _on_timer_timeout():
	var laser = preload("res://TestScene3/Scenes/LaserBeam.tscn").instantiate()
	add_child(laser)
	laser.rotation_speed = max_rotation_speed
	laser.damage = max_laser_damage
	laser.lifespan_duration = max_laser_lifespan_duration
	laser.global_position = global_position
	laser.global_rotation = randf_range(0,2*PI)
	
	
	
