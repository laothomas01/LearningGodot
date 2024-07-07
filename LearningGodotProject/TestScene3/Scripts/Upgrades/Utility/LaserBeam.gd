extends Node2D

@export var rotation_speed = 0
@export var lifespan_duration = 0
@onready var lifespan_timer = $Lifespan
var damage = 0

func _ready():
	lifespan_timer.wait_time = lifespan_duration 
	lifespan_timer.start()

func _process(delta):
	global_rotation += deg_to_rad(1) * rotation_speed * delta

func _on_lifespan_timeout():
	queue_free()

func _on_area_entered(area):
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(damage)
