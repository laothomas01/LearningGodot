extends Node2D

@export var moveSpeed = 1
var level = 1
var travel_distance = 0
var damage = 1
var velocity = Vector2.ZERO


func _ready():
	pass
	
func _process(delta):
	global_position += velocity * moveSpeed * delta 

func _enemyHit():
	queue_free()	
func _on_life_span_timeout():
	queue_free()
