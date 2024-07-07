extends Area2D

var move_speed = 200
var move_direction = Vector2.ZERO
var damage  = 1
var piercing_charges = 0
var target = null
var lifespan = 1
@onready var timer = get_node("Lifespan")
@onready var detection_area = get_node("DetectionAreaHitbox")

enum 
{
	NORMAL,
	EXPLOSIVE,
	POISON,
	PIERCING,
	HOMING
}

var type : int = NORMAL

func _ready():
	print(type)
	if type == HOMING:
		detection_area.process_mode = Node.PROCESS_MODE_PAUSABLE
	timer.start()
		
func _process(delta):
	if type == HOMING:
		if  is_instance_valid(target):
			move_direction = (target.global_position - position).normalized()
		
	position += move_speed * move_direction * delta 
	
"""
where to handle projectile behavior upon collision 
"""


"""
current solution:
	- preventing multiple collisions when there exists overlapping area 2D 
	- for singular collisions
	- will need to apply to to EVERY projectile used for hit detection 
"""
var has_hit = false
func _on_area_entered(area):
	if has_hit:
		return
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(damage)
		has_hit = true
		queue_free()
	
func set_type(type_name):
	match type_name:
		"HOMING":
			type = HOMING
func set_damage(dmg):
	damage = dmg 
func set_pos(position):
	global_position = position
func set_speed(speed):
	move_speed = speed	
#	match bullet_type:
#		Type.EXPLOSIVE:
#			var explosion = preload("res://TestScene3/Scenes/ExplosionArea.tscn").instantiate()
#			explosion.global_position = global_position
#			get_parent().add_child(explosion)
#		Type.NORMAL:
#			pass
			
		
	
"""
can modify lifespan of projectile based on type if we want 
"""
func _on_lifespan_timeout():
	queue_free()

"""
for area detection if type of projectile desires 
"""
func _on_detection_area_hitbox_area_entered(area):
	target = area
