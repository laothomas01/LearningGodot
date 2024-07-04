extends Area2D

@onready var character = get_tree().get_first_node_in_group("character")

var angle_offset = 0
var angle = 0
var orb_rotate_speed = 2000

func _ready():
	pass
func _process(delta):
	angle += PI/180 * 2
	global_position = character.position + Vector2(cos(angle + angle_offset ),sin(angle + angle_offset)) * 100
#	angle += PI/180 * 10 * delta
#	position = character.position + Vector2(cos(deg_to_rad(angle + angle_offset )),sin(deg_to_rad(angle + angle_offset)))
#
