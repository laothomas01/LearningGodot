"""

hurtbox - area player can be hit 
hitbox -  interacts with hurtbox. owner of hurtbox receives damage or healing from collider"s hitbox 
do  we need a state machine? 

things to complet for player:
Implementation:
[]
[] 
Testing:
	
beginner topics:

[x] player detects enemy
[x] player attack detected enemy
[x] player shoots in random direction when found no target
[x] player undetects enemy
[x] player"s attack removes itself when colliding with enemy
[x] player"s attack removes itself when lifespan times out 
[x] player continously levels if exp gained is greater than max 
[x] upgrading abilities work 
[] player death
[x] enemy death
[x] enemy drops exp
[x] stat upgrades to abilities
[]  special projectile behaviors 
[x] check if player already has ability
[] select from an array of different abilities when leveling up or upgrading 
[] scale/clean this code 
[] more specialized gems 

advanced topics:
	
"""


extends CharacterBody2D


"""
[ ] close combat attack timer
[ ] area attack timer 

"""

"""


handles changes to player transform without affecting parent 


"""

@onready var transform2D = get_node("Transform2D")

"""

Player attributes:
	- 
"""	
@export var move_speed = 1
var exp_cap = 4
var exp = 0
var max_health = 10
var health = max_health


var detected_enemies = []
var move_direction = Vector2.ZERO

var upgrade_database = {
	
	"ranged_attack" : get_node("Attack/RangedAttack"),
	"close_combat" : get_node("Attack/CloseCombat"),
	"area_combat" : get_node("Attack/AreaCombat")
	
}


var ranged_attack = null
var close_combat = null 

var collected_upgrades = []

func _ready():
	upgrade_character("close_combat")
	upgrade_character("ranged_attack")
	
	"""d
	for globally updating variables, we need to instnatiate the object early on
	"""
	
func _process(delta):
		move_direction = Input.get_vector("move_left","move_right","move_up","move_down")
		move_direction.normalized();	
		_set_face_direction(move_direction)		
		
		if Input.is_action_just_pressed("Dash") && move_direction.length() > 0:
			print('Dash')
			_update_velocity(move_direction,move_speed * 10,delta)
		else:
			_update_velocity(move_direction,move_speed,delta)
		
		"""
		if obtained abilities are not null, player should feed them information so 
		they can behave as coded 
		"""
		if	ranged_attack:
			ranged_attack._update_target_position(_detect_random_enemy())
		
func _physics_process(delta):
		move_and_slide()

func _update_velocity(move_direction,speed,delta):
		velocity = Vector2(move_direction.x,move_direction.y) * speed * delta
	
func _set_face_direction(direction:Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0:
		transform2D.scale.x = scale_x
		
"""
if enemy not nearby, detect a random position
this looks like a feature better suited for ranged attack 

[] migrate to ranged attack script if so 

is this function only for ranged attacks??? 
"""
func _detect_random_enemy():
	if detected_enemies.size() > 0:
		return detected_enemies.pick_random().global_position
	else:
		var viewport_size = get_viewport_rect().size
		var rand_x = randf_range(-viewport_size.x,viewport_size.x)
		var rand_y = randf_range(-viewport_size.y,viewport_size.y)
		return Vector2(rand_x,rand_y)
		
"""
let"s follow this upgrade pattern for simplicity:
	- each special upgrade will have it"s own branching selection upgrades 
		- what do i mean?
			- ex:	
				for ranged_attack, you have a choice 
"""

func upgrade_character(upgrade):
	print("upgrading: ", upgrade)
	"""
	- if character does not have the selected upgrade, select it for the first time
		- add to collected_upgrades list, start the attack timer 
	- else, just power it up 
	"""
	if collected_upgrades.has(upgrade):
#		print("has ",upgrade)
		match upgrade:
			"ranged_attack":
				ranged_attack.upgrade()
	else:	
		collected_upgrades.append(upgrade)
		# initialize the ranged attack 
		match upgrade:
			"ranged_attack":
				ranged_attack = get_node("Attack/RangedAttack")
				ranged_attack.start_timer()
			"close_combat":
				close_combat = get_node("Attack/CloseCombat")
				close_combat.start_timer()
""""
will need a collection area 2D box to use this 
"""
func calculate_experience_gain(gem_experience):
	exp += gem_experience
	while exp >= exp_cap:
		print("level up")
		"""
		we will just upgrade 1 skill right now. in the future, this will 
		randomly choose from list of upgrades
		"""

		upgrade_character("ranged_attack")
		exp -= exp_cap
		

func _on_hurt_box_hurt(damage):
	health -= damage 
	if health <= 0:
		print("has died")
# add undetected enemies 
func _on_detection_area_area_entered(area):
	if not detected_enemies.has(area):
		detected_enemies.append(area)
# if enemy is undetected, remove detected enemy 
func _on_detection_area_area_exited(area):
	if detected_enemies.has(area):
		detected_enemies.erase(area)
#func _dash():
	
#check what area is: coin, item, gem? 
# if gem, gain exp 
func _on_collection_area_area_entered(area):
	match area.item_name:
		"gem":
			calculate_experience_gain(area.exp)
