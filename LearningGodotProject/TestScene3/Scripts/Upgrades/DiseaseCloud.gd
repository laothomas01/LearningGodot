extends Node2D

@export var damage = 10
@export var damage_area_lifespan = 10
var disease_cloud_cooldown = 2
@onready var timer = get_node("Timer")
func _ready():
	timer.wait_time = disease_cloud_cooldown
	timer.start()
func _process(delta):
	pass

func _on_timer_timeout():
#	pass
	var damage_area = preload("res://TestScene3/Scenes/Abilities/DamageArea.tscn").instantiate()
	damage_area.set_lifespan(1000)
	damage_area.global_position = global_position
	add_child(damage_area)
	
	

	
	

	
	
