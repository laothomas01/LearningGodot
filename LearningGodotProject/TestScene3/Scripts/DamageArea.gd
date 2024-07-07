extends Area2D
@onready var timer = get_node("Timer")
var lifespan = 100
var damage = 1

func _ready():
#	print('Damage Area ready')
	timer.wait_time = lifespan
	timer.start()
	
func set_lifespan(time):
	lifespan = time
func set_damage(dmg):
	damage = dmg
func _on_lifespan_timeout():
	queue_free()

func _on_area_entered(area):
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(damage)
