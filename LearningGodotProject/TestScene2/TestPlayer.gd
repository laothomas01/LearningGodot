extends CharacterBody2D
#
#
const SPEED = 300.0
var maxhealth = 50.0
var health = maxhealth 
var enemy_close = []
var level = 1
var collected_upgrades = {}
var exp = 0
var maxExp = 10

"""
- how to handle ability upgrades???
	- 1) we can keep track of our upgrade levels inside the player scene 
		ex: ice_spear_level = 2 
			var spear = preload("ice_spear").instantiate
			spear.level = ice_level 
		
			- in ice_spear.tscn, handle scene behavior based on current level 
			

"""


"""

we can test level up and upgrades by creating a data base of potential upgrades 
and wiring it so when player levels up, the game will automatically pick an ability for the player


"""
# variable to store changes to player transform 
@onready var transform_adjustment = get_node("TransformAdjustment2D")
@onready var range_attack_timer = get_node("Attack/RangeAttackTimer")
@onready var close_attack_timer = get_node("Attack/CloseAttackTimer")

var upgrades = {
	"ranged" : preload("res://TestScene2/RangedAttack.tscn"),
	"melee" : preload("res://TestScene2/CloseCombatAttack.tscn")
}


func _ready():
	pass
#	range_attack_timer.start()
#	close_attack_timer.start()
	
"""
logic i need:
		- player taps left, player should be flipped left side
"""
func _process(delta):
		var move_direction = Input.get_vector("move_left","move_right","move_up","move_down")
		move_direction.normalized()
		set_character_facing_direction(move_direction)
		velocity = Vector2(move_direction.x,move_direction.y) * SPEED  
	
func _physics_process(delta):
		move_and_slide()

#func set_character_facing_direction(direction:Vector2):
#	var scale_x = sign(direction.x)
#	if scale_x != 0:
#		scale.x = scale_x

func set_character_facing_direction(direction:Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0:
		transform_adjustment.scale.x = scale_x

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return null
"""
gaining exp:
	- kill enemy
	- update exp variable
level up:
	- exp >= maxExp
		- what if maxExp = 10 and exp = 12?
			- level up
			- exp -= maxExp 
		- what if maxExp = 10 and exp = 20?
			- level up
			- exp -= maxExp
					20 = 20 - 10 = 10 
					exp  >= max exp 
					level up
					exp = exp - maxExp 
		
"""

func _levelup():
	pass

func _on_hurt_box_hurt(damage):
	health -= damage 



#attack only if a target is in sight
func _on_range_attack_timer_timeout():
	if get_random_target() != null:
		pass
#		var rangedAttack = range_attack.instantiate()
#		rangedAttack.position = position
#		rangedAttack.target = get_random_target()
#		add_child(rangedAttack)
	
func _on_detection_area_area_entered(area):
	if not enemy_close.has(area):
		enemy_close.append(area)
func _on_detection_area_area_exited(area):
	if enemy_close.has(area):
		enemy_close.erase(area);

func _on_close_attack_timer_timeout():
	pass
#	var closeAttack = close_attack.instantiate()
#	add_child(closeAttack)
