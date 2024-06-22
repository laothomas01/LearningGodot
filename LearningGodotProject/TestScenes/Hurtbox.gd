extends Area2D



@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)

# encounter area2D hurtbox is interacting with
# send out hurt signal 
# damage can also mean "healing" 
func _on_area_entered(area):
	var damage = area.damage 
	print("Receiving Damage From:", area)
	print("Damage Received:", damage)
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()
	emit_signal("hurt",damage)
# reset hurtbox 
func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
