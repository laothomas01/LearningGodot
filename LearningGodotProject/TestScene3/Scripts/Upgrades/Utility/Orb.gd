extends Area2D

@onready var character = get_tree().get_first_node_in_group("character")

var angle_offset = 0
var angle = 0
var orb_rotate_speed = 0
var damage = 0
func _ready():
	print('orb damage:',damage)
func _process(delta):
	# where the rotation happens :p
	angle += PI/180 * orb_rotate_speed * delta
	global_position = character.position + Vector2(cos(angle + angle_offset ),sin(angle + angle_offset)) * 100
#	angle += PI/180 * 10 * delta
#	position = character.position + Vector2(cos(deg_to_rad(angle + angle_offset )),sin(deg_to_rad(angle + angle_offset)))

func set_damage(dmg):
	damage = dmg
func set_speed(speed):
	orb_rotate_speed = speed 


func _on_area_entered(area):
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(damage)
