extends Area2D
var move_speed = 1
var move_direction = Vector2.ZERO
var damage  = 1
var has_collided = false

enum Type
{
	NORMAL,
	EXPLOSIVE,
	POISON,
	PIERCING
}

var bullet_type 

func _ready():
	pass
#	print("projectile damage ", damage)
#	bullet_type = Type.EXPLOSIVE
func update_direction(direction):
	move_direction = direction
# Called when the node enters the scene tree for the first time.
func _process(delta):
	position += move_speed * move_direction * delta 
	
func _on_area_entered(area):
	queue_free()
	
	"""
	
	- experimenting with explosive areas 
	
	"""
#	match bullet_type:
#		Type.EXPLOSIVE:
#			var explosion = preload("res://TestScene3/Scenes/ExplosionArea.tscn").instantiate()
#			explosion.global_position = global_position
#			get_parent().add_child(explosion)
#		Type.NORMAL:
#			pass

