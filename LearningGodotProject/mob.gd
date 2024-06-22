extends CharacterBody2D

var player
var health = 3
func _ready():
	player = get_node("/root/Main/Player")
	
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 50.0
	move_and_slide()
	
func take_damage():
	health -= 1
	if health == 0:
		var expDrop = preload("res://ExpDrop.tscn").instantiate()
		expDrop.global_position = global_position
		get_parent().add_child(expDrop)		
		queue_free()
		
		
