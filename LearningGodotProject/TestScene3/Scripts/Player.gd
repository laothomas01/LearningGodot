extends CharacterBody2D


"""
Classes player can player as:
	- Werewolf
		- starting upgrade:
			- slash
		- base stats:g
			- increased damage
			- increased health 
	- Vampire
		- 
	- Lich
	- Cthulu
"""


"""
PLAYER BASIC ATTRIBUTES 
"""
@onready var transform2D = get_node("TransformAdjustment")
@onready var animation = get_node("TransformAdjustment/AnimatedSprite2D")
@export var move_speed = 1

var max_exp = 4
var current_exp = 0 # do we want to turn exp into in game currency instead? for buying upgrades?? 
var maxhealth = 100
var current_health = 0
var move_direction = Vector2.ZERO
var last_direction = Vector2.ZERO
var lifesteal_heal = 0
var lifesteal_probability = 0
var regenerate_heal = 0
var regenerate_rate = 0
var activate_ragemode = false 
var ragemode_damage_bonus = 0
var ragemode_attackspeed_bonus = 0
var move_speed_bonus = 0
var maxhealth_bonus = 0

"""
- maybe seperate some skills to be specific to the chosen played class
- the rest of the skills are universal 
- 
"""
var upgrade_choice = [
	# hits multiple enemies
	"slash",
	# currently hits one enemy at a time
	"howl",
	# hits one enemy at a time 
	"homing missiles",
	# hits multiple enemies 
	"laser eyes",
	#hits multiple enemies 
	"disease cloud",
	# hits multiple enemies 
	"orbit thing",
	"rage mode",
	"life steal",
	"regenerate",
	"increase move speed",
	"increase max health",
	"heal"
]

enum
{
	WEREWOLF,
	VAMPIRE,
	DEEPONE,
	LICH,
	ANTICHRIST,
	HERETIC
}

enum {
	IDLE,
	WALK,
	DEATH,
	RUNNING,
	HURT,
	ATTACK,
	LEVEL_UP
}

var state: int = WALK:
	set(value):
		state = value
		match state:
			IDLE:	
				idle_state()
			WALK:
				walk_state()
			RUNNING:
				running_state()
			HURT:
				hurt_state()
			ATTACK:
				attack_state()
			DEATH:
				pass
				
signal leveled_up()

@onready var game_manager = get_parent().get_node("GameManager")

# all available attacks player can obtain 
# make them global variables incase data needs to change 


"""
OFFENSIVE ABILITIES 
"""

#instances of offensive abilities 
#var ranged_attack = null
#var close_combat = null 
#var area_combat = null 



# instances of abilities with more complex behavior 
var slash = null
var howl = null
var homing_missiles = null
var laser_eyes = null
var disease_cloud = null
var orbit_thing = null

"""
STATUS EFFECTS
- we can put this into a dictionary later 
- also use inheritance to reduce lines of code 
"""


# # applied from external entities
# # will figure out debuffs later  
# var is_weakened = false 
# var	weaken_amount = 0

var last_move_direction = Vector2.ZERO

"""
PASSIVE ABILITIES 
"""
# player passive abilities 
# var life_steal_recovery = 0
# var life_steal_probability = 0

var collected_upgrades = []


"""
smoke check all these abilities:
	
	[x] slash 
	[x] howl
	[x] homing missiles 
	[x] laser eyes  
	[x] disease cloud 
	[x] regenerate  
	[x] rage mode
	[x] increase move speed
	[x] disease cloud
	[] life steal 
"""
func _ready():
	connect("leveled_up",Callable(game_manager,"on_level_up"))
	# starting upgrade for current class: werewolf 
#	upgrade_character("slash")
#	upgrade_character("howl")
	# upgrade_character("homing missiles")
#	upgrade_character("laser eyes")
#	upgrade_character("disease cloud")
#	upgrade_character("orbit thing")
#	upgrade_character("regenerate")
#	upgrade_character("rage mode")
#	connect("leveled_up",Callable(self,"test"))

	upgrade_character("increase move speed");
	# activate_ragemode = true
	current_health = maxhealth * 0.5
	experience_gain(20)
	
	
	
func attack_state():
	animation.play("Attack")
	
func running_state():
	animation.play("Run")

func hurt_state():
	if current_health <= 0:
		pass
	else:
		animation.play("Hurt")
		await animation.animation_finished
		state = IDLE
		if not activate_ragemode and current_health <= maxhealth/2 and collected_upgrades.has("rage mode"):
			activate_ragemode = true
		
func idle_state():	
	animation.play("Idle")
func walk_state():
	animation.play("Walk")
	
func _process(delta):
		_handle_user_input()
		if state != HURT:
			state = WALK if velocity.length_squared() > 0 else IDLE 
		
		if move_direction != Vector2.ZERO:
			last_move_direction = move_direction.normalized()
		velocity =  move_direction * move_speed * delta	
		_set_face_direction(move_direction)
				
func _physics_process(delta):
		move_and_slide()

func _handle_user_input():
	move_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
func _set_face_direction(direction:Vector2):
	var scale_x = sign(direction.x)
	if scale_x != 0:
		transform2D.scale.x = scale_x
	
# [ ]  it's functional 
	# [x] healing
	# [x] obtaining upgrades 
	# [ ] upgrading abilities 
	
func upgrade_character(upgrade):
	
	print('upgrade: ',upgrade)
	
	"""
	- if character does not have the selected upgrade, select it for the first time
		- add to collected_upgrades list, start the attack timer 
	- else, just power it up 
	"""
	
	if upgrade == 'heal':
		healing(10)
	# TODO LIST: upgrade abilities 
	elif collected_upgrades.has(upgrade):
		print('upgrading:' ,upgrade)
		match upgrade:
			"slash":
				pass
	else:	
		collected_upgrades.append(upgrade)
		print('you have obtained ability: ', upgrade)
		match upgrade:
			#  ============================ OFFENSE ABILITIES ============================
			"slash":
				slash = preload("res://TestScene3/Scenes/Abilities/CloseCombat.tscn").instantiate()
				add_child(slash)
			"howl":
				howl = preload("res://TestScene3/Scenes/Abilities/Howl.tscn").instantiate()
				add_child(howl)
			"homing missiles":
				homing_missiles = preload("res://TestScene3/Scenes/Abilities/Homing_Missiles.tscn").instantiate()
				add_child(homing_missiles)
			"laser eyes":
				laser_eyes = preload("res://TestScene3/Scenes/Abilities/LaserEyes.tscn").instantiate()
				add_child(laser_eyes)
			"disease cloud":
				disease_cloud = preload("res://TestScene3/Scenes/Abilities/DiseaseCloud.tscn").instantiate()
				add_child(disease_cloud)
			"orbit thing":
				orbit_thing = preload("res://TestScene3/Scenes/Abilities/OrbitProjectiles.tscn").instantiate()
				add_child(orbit_thing)
				orbit_thing.create_orbs()
			
			# ============================= PASSIVE ABILITIES =================================
			"life steal":
				lifesteal_heal = 1
				lifesteal_probability = 0.1
			"regenerate":
				regenerate_heal = 1
				regenerate_rate = 1
				var regenerate_timer = Timer.new()
				regenerate_timer.name = "regenerate_timer"
				regenerate_timer.connect("timeout",Callable(self,"regenerate_timer_timeout"))
				add_child(regenerate_timer)
				regenerate_timer.wait_time = regenerate_rate
				regenerate_timer.start()
			"rage mode":
				ragemode_attackspeed_bonus = 0.1
				ragemode_damage_bonus = 3
			# =========================== STAT BONUSES =========================================
			"increase move speed":
				move_speed_bonus = 0.1
				modify_move_speed(move_speed_bonus)
			"increase max health":
				modify_maxhealth(1)
			# ============================ ITEMS ================================================
			
#[x] gain experience 
# we can gain exp after collecting exp gems 
func experience_gain(gem_experience):
	print('gem_experience: ',gem_experience)
	current_exp += gem_experience
	print('current_exp:', current_exp)
	while current_exp >= max_exp:
		"""
		too lazy to set up gui and graphics. 
		current code selects random upgrade and uses that as a way for player to select upgrade 
		"""
		# upgrade_character(upgrade_choice.pick_random())
		current_exp -= max_exp
		emit_signal('leveled_up')
	print('current_exp:', current_exp)
	
	
# we can take damage 
func _on_hurt_box_hurt(damage):
	current_health -= damage 
	state = HURT

# we can trigger an enemy signal and perform player functions 
	# eg: life steal g
func enemy_hit():
	if randi() % 100 + 1 < lifesteal_probability * 100:
		healing(lifesteal_heal)

# we can heal	
func healing(value):
	print('current health:',current_health)
	if current_health >= maxhealth:
		current_health = maxhealth
	else:
		if current_health > maxhealth * 0.5:
			activate_ragemode = false
			print(activate_ragemode)
		current_health += value
	
# regenerate over time 
func regenerate_timer_timeout():
	healing(regenerate_heal)
	
# apply move speed bonus 
func modify_move_speed(bonus):
	move_speed = move_speed + (move_speed * bonus)

# apply max health bonus 
func modify_maxhealth(bonus):
	if current_health == maxhealth:
		maxhealth += maxhealth + bonus
		current_health = maxhealth
	else:
		maxhealth += maxhealth + bonus


"""
enum {
	IDLE,
	WALK,
	DEATH,
	RUNNING,
	HURT,
	ATTACK,
	LEVEL_UP
}
"""
func get_state_string():
	var state_string = ''
	match state:
			IDLE:
				state_string = 'IDLE'
			WALK:
				state_string = 'WALK'
			DEATH:
				state_string = 'DEATH'
			RUNNING:
				state_string = 'RUNNING'
			HURT:
				state_string = 'HURT'
			ATTACK:
				state_string = 'ATTACK'
			LEVEL_UP:
				state_string = 'LEVEL_UP'
	return state_string
#
#func test():
#	print('leveld up')		
	
