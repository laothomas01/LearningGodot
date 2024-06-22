extends Area2D

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer
signal hurt(damage)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# range attack hit box -> enemy hurt box 
# enemy hit box -> player hurt box 
func _on_area_entered(area):
#	print("Current Object:",get_parent().name)
#	print("Receiving Damage From:",area.get_parent().name)
	var damage = area.damage 
	# when player takes damage, disable hurtbox
	#these are what we will call: i-frames/invincible frames
	#disabling the hurtbox prevents plaer from taking damage  
	collision.call_deferred("set", "disabled", true)
	disable_timer.start()
	emit_signal("hurt",damage)
	
func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
	
