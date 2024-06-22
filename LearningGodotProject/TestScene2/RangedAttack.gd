extends Area2D

var target = Vector2.ZERO
var trajectory = Vector2.ZERO
@export var damage = 1
@export var moveSpeed = 1
var level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	trajectory = global_position.direction_to(target)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	position += trajectory * moveSpeed * delta 

# free up memory once attack has collided with enemy hurt box
#note: this can be modified with more complex behavior 
func _on_area_entered(area):
	queue_free()

# if attack is out for too long, free up memory 
func _on_lifespan_timeout():
	queue_free()
