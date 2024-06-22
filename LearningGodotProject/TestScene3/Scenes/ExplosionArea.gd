extends Area2D



var damage = 1
func _ready():
	var lifespan = get_node("Timer")
	lifespan.start()

func _on_timer_timeout():
	queue_free()
