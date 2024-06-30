extends CharacterBody2D

"""
PLAYER BASIC ATTRIBUTES 
"""
@onready var transform2D = get_node("TransformAdjustment")
@onready var animation = get_node("TransformAdjustment/AnimatedSprite2D")
@export var move_speed = 1
var exp_cap = 4
var current_exp = 0
var max_health = 100
var current_health = max_health
var detected_enemies = []
var move_direction = Vector2.ZERO
var last_direction = Vector2.ZERO

"""
PLAYER UPGRADE DATABASE 
"""
var upgrade_choice = [
	"slash","shove","howl","homing_missiles",
	"laser eyes","disease cloud","orbit thing","reflect",
	"rabies","rage mode","life steal","regenerate","increase move speed","increase item pick up range"
	]

"""

Werewolf class toolkit 

upgrades:
	
COMBAT ABILITIES:(2 melee, 3 ranged, 2 area)
	[x]  slash:
			offense combat ability:
				- basic melee attack
	[] shove:
			offsense combat ability:
				- no damage dealing
				- knocks back enemy 
	[x] howl: 
			offense combat ability:
				- basic ranged combat attack that moves in the direction player is facing 
				- no auto targetting
					ex: facing left, projectile flies left. facing right, projectile flies right. etc... top, bottom 
	[x] homing missiles:
			offense combat ability:
				- basic range combat attack.
				- finds nearest enemy, calculates trajectory between enemy and projectile, moves to target 
	
	[] laser eyes:
			- offense combat ability:
				- player fires a laser that rotates for a duration hitting any enemies it encounters 
	- disease cloud:
			- offense combat ability:
				- player unleashes an area damage dealing cloud 
					- damage dealt to enemies entering area
					- does damage over time to enemies 
	- object orbits player:
			- offense combat ability:
				- player gains a rotating orb 
				- enemies hit by orb take damage 
	- chain lightning
	- bouncing ranged attack
	- exploding ranged attack 
	- instantenous vaporization 
		- single target a random enemy and by chance, just instantly kill the enemy
	
	- bring on the apocalypse
		- nuke all enemies and clear the screen 
	- fire breath
		- shoot a coned box collider that damages enemy in the colider
	- throw pillars at enemis
		- spawn colliders that can knockback enemies and deal damage 
		- enemies cannot walk past these pillars if they are still instantiated 
	- fire walk:
			- spawn an area where if enemy walks into, enemy takes damage
	- 		
PASSIVE ABILITIES:
	- reflect damage:
			offense passive ability:
				- player deals damage to enemies attacking player 
	- rabies:
			- offensive passive ability:
				- if damage dealt to enemy, player has chance to infect enemy and cause enemy to attack other enemies 
	- rage mode:
			- offense passive ability:
				- if current_health < 1/2 of max current_health: activate rage ability
					- apply bonus attack speed to offensive combat abilities
					- apply bonus attack damage to offsenive combat abilities 
	- life steal:
			- defense passive ability:
					- on dealing damage to enemy, player has chance to heal 
	- regenerate:
			- defense passive ability:
					- player over time heals a certain amount 
	- temporary invulnerable
	
	- cloak:
			- can walk through enemeis 
	corpse explosion
			- on enemy death, trigger an area of damage
	
BASIC STAT BONUSES: 				
	- increase move speed
			- stat upgrade:
					- player moves faster
	- increase item pick up range:
			- stat upgrade:
					- player pickup item range is increased
		
"""

enum {
	IDLE,
	WALK,
	DEATH,
	RUNNING,
	HURT,
	ATTACK
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
			DEATH:#
				pass


# all available attacks player can obtain 
# make them global variables incase data needs to change 


"""
OFFENSIVE ABILITIES 
"""

#instances of offensive abilities 
#var ranged_attack = null
#var close_combat = null 
#var area_combat = null 

var slash = null
var howl = null
var homing_missiles = null

"""
STATUS EFFECTS
- we can put this into a dictionary later 
- also use inheritance to reduce lines of code 
"""
#acquired through skills 
var in_rage_mode = false 
# player buffs,debuffs 
#var weaken_damage_reduction = 0
var rage_mode_damage_bonus = 0
var rage_mode_attack_speed_bonus = 0

# applied from external entities
# will figure out debuffs later  
var is_weakened = false 
var	weaken_amount = 0
var last_move_direction = Vector2.ZERO

"""
PASSIVE ABILITIES 
"""
# player passive abilities 
var life_steal_recovery = 0
var life_steal_probability = 0

var collected_upgrades = []

func _ready():
	# starting upgrade for current class: werewolf 
	upgrade_character("slash")
	upgrade_character("howl")
	upgrade_character("homing missiles")
	
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
		if not in_rage_mode and current_health <= max_health * 0.5 and collected_upgrades.has("rage_mode"):
			print('in rage mode!')
			in_rage_mode = true
		
func idle_state():	
	animation.play("Idle")
func walk_state():
	animation.play("Walk")
	
	
	
	"""
	
	each skill we acquire will have a base damage and any bonus damages calculated
	
	handle passive skills inside the player script:
		ex: debuffs or bonuses
			ex: rage, weaken
			
			if rage:
				close_combat.dmg += close_combat.dmg * rage_bonus 
			
			if weakened:
				close_combat.dmg -= close_combat.dmg * weaken bonus 
				
			this way, we can box our abilities' attributes and box our player's attributes
				
	
	"""
func _process(delta):
		_handle_user_input()
		var current_move_speed = move_speed
			# if you are moving
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
	
func _update_velocity(move_direction,speed,delta):
		pass
			
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


#"""
#
#perhaps move this to a ranged targetting skill? 
#
##"""
#func _detect_random_enemy_position():
#	if detected_enemies.size() > 0:
#		return detected_enemies.pick_random().global_position
#	else:
#		# just find a random location in the viewport and shoot 

#		return Vector2(rand_x,rand_y)
#
#func _detect_random_enemy():
#	if detected_enemies.size() > 0:
#		return detected_enemies.pick_random()
#
#func _get_first_detected_enemy():
#	if detected_enemies.size() > 0:
#		return detected_enemies[0]
#
##func _first_seen_enemy():
##	if detected_enemies.size() > 0:
##		return detected_enemies[0]
##	else:
##		return null
#
#func _get_detected_enemies():
#	return detected_enemies

		
"""

what is an upgrade? items, abilities, passive abilities, stat increase 

"""

func upgrade_character(upgrade):
	"""
	- if character does not have the selected upgrade, select it for the first time
		- add to collected_upgrades list, start the attack timer 
	- else, just power it up 
	"""
	
	if collected_upgrades.has(upgrade):
		print('upgrading:' ,upgrade)
#		print("has ",upgrade)
		match upgrade:
			"slash":
				pass
#			"ranged_attack":
##				ranged_attack.upgrade()
#				pass
#			"close_combat":
#				pass
##				close_combat.upgrade() # <- do we want do it like this???? 
#			"life_steal":
#				life_steal_recovery += 1
	else:	
		collected_upgrades.append(upgrade)
		print('you have obtained ability: ', upgrade)
		match upgrade:
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
				pass
					
				
#			"ranged_attack":
##				ranged_attack = get_node("Attack/RangedAttack")
##				ranged_attack.start_timer()
#				pass
#			"close_combat":
##				close_combat = get_node("Attack/CloseCombat")
##				close_combat.start_timer()
#				pass
#			"life_steal":
#				life_steal_recovery = 1
#				life_steal_probability = 0.1
#			"rage_mode":
#				rage_mode_attack_speed_bonus = 0.1
#				rage_mode_damage_bonus = 0.4

func calculate_experience_gain(gem_experience):
	current_exp += gem_experience
	while current_exp >= exp_cap:
		"""
		we will just upgrade 1 skill right now. in the future, this will 
		randomly choose from list of upgrades
		"""
		upgrade_character(upgrade_choice.pick_random())
#		upgrade_character("ranged_attack")
		current_exp -= exp_cap


func _on_hurt_box_hurt(damage):
	current_health -= damage 
	print(current_health)
	state = HURT
#	state = HURT
#	if current_health <= 0:
#		print("has died")
# add undetected enemies 
#func _on_detection_area_area_entered(area):
#	if not detected_enemies.has(area):
#		detected_enemies.append(area)
## if enemy is undetected, remove detected enemy 
#func _on_detection_area_area_exited(area):
#	if detected_enemies.has(area):
#		detected_enemies.erase(area)
#func _dash():
	
#check what area is: coin, item, gem? 
# if gem, gain current_exp 
func _on_collection_area_area_entered(area):
	match area.item_name:
		"gem":
			calculate_experience_gain(area.current_exp)


# for every enemy that takes damage, make sure it sends a "hit" signal 
func enemy_hit():
	if randi() % 100 + 1 < life_steal_probability * 100:
	#TODO: add in probability of recovery s
		healing(life_steal_recovery)
	
func healing(value):
	print('healing amount: ')
	print(value)
	if current_health >= max_health:
		print('at full current_health')
		current_health = max_health
	else:
		if current_health > max_health * 0.5:
			print('off rage mode')
			in_rage_mode = false
			print(in_rage_mode)
		print('current current_health:')
		print(current_health)
		current_health += value
		
func set_state(state):
	state = state
