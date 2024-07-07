extends Node2D

var orb_count = 1
var orb_damage = 1
var orb_rotate_speed = 150
var orbs = [] 

func create_orbs():
	for i in orb_count:
		var orb = preload("res://TestScene3/Scenes/Abilities/Orb.tscn").instantiate()
		orb.angle_offset = i * (2 * PI / orb_count)
		orb.set_damage(orb_damage)
		orb.set_speed(orb_rotate_speed)
		add_child(orb)
		orbs.append(orb)
	print(orbs.size())
func reset_orbs():
	for orb in orbs:
		if is_instance_valid(orb):
			orb.queue_free()
	orbs.clear()

	
		
		
		
		
