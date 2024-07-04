extends Node2D

var orb_count = 1
var orb_damage = 1
var orbs = [] 

func create_orbs():
	print('creating orbs')
	for i in orb_count:
		var orb = preload("res://TestScene3/Scenes/Abilities/Orb.tscn").instantiate()
		orb.angle_offset = i * (2 * PI / orb_count)
		add_child(orb)
		orbs.append(orb)
	print(orbs.size())
func reset_orbs():
	print('removing orbs')
	for orb in orbs:
		if is_instance_valid(orb):
			orb.queue_free()
	orbs.clear()
	print(orbs.size())

	
		
		
		
		
