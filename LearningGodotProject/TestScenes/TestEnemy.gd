extends CharacterBody2D

var max_health = 50.0 
var health = max_health

func _on_hurt_box_hurt(damage):
	health -= damage 
	
