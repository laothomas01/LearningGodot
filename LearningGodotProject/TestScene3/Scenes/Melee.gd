extends Area2D


var damage = 1

func _on_life_span_timeout():
	
	queue_free()
