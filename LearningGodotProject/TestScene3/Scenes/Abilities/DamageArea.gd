extends Area2D
@onready var timer = get_node("Timer")
var lifespan = 1
var damage = 1

func _ready():
	print('Damage Area ready')
	timer.wait_time = lifespan
	timer.start()
func set_lifespan(time):
	lifespan = time
func set_damage(dmg):
	damage = dmg
func _on_lifespan_timeout():
	queue_free()



