extends Area2D

@export var moveSpeed = 1

var level = 1
var direction = Vector2.ZERO
var target = Vector2.ZERO
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called s frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = global_position.direction_to(target)
	global_position +=  direction * moveSpeed * delta

func _on_area_entered(area):
	queue_free()
