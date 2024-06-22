extends Area2D

var expAmount = 1



func _on_body_entered(body):
	if body.has_method("gainexp"):
		body.gainexp(expAmount)
		queue_free()
		
