"""
this may need to inherit from a base class so we
dont have to repeat same code for coding projectiles 
"""
extends Area2D

@export var moveSpeed = 0 

var level = 1
var travel_distance = 0
var velocity = Vector2.ZERO
func _process(delta):
	
	const RANGE = 1000
	position += velocity * moveSpeed * delta 
	travel_distance += moveSpeed * delta 
	if travel_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
