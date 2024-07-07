extends Area2D


var damage = 1

func _ready():
#	print("melee damage: ", damage)
	pass
func _on_life_span_timeout():
#	print('melee timeout')
	queue_free()
func set_damage(dmg):
	damage = dmg 
func set_pos(position):
	global_position = position


"""
can hit multiple colliders 
"""
func _on_area_entered(area):
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt(damage)
