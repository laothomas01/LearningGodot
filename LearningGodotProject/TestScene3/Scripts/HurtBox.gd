extends Node
""" 
this can be modified with a FINITE STATE MACHINE
	- states can be used to classify types of interactions 
		- TAKING DAMAGE
		- NOT TAKING DAMAGE
	- or find another soluton :p ....

what is an iframe:
	- upon collsion with a hitbox, disable collider and renable after N number of seconds 


"""

@onready var disable_timer = $DisableTimer
@onready var collision = $CollisionShape2D

signal hurt(damage)

func _on_area_entered(area):
#	if not area.has_collided:
	var damage = area.damage 
	collision.call_deferred("set","disabled",true)
	disable_timer.start()
	emit_signal("hurt",damage)

func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled",false)
	
