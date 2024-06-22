extends CharacterBody2D


var rotationAngle = 0
@export var moveSpeed = 0
@export var rotationSpeed = 1
# key value pair determining if player has an ability or not 
var playerLevel = 1
var currentExperience = 0
var maxExperience = 10
var hp = 80
var maxhp = 80

"""
- to contain database of abiities player can obtain 
"""
@onready var rangeAttackTimer = get_node("RangedAttackTimer")

var abilityDB = {
	"ranged" : preload("res://Abilities/RangedAttack.tscn")
#	"ranged" : preload("res://Abilities/RangedAttack.tscn"),
#	"closecombat" : preload("res://Abilities/CloseCombat.tscn")
}
var collectedAbilities = {
	
}
# we loaded the resource
#var rangedAttack = preload("res://Abilities/RangedAttack.tscn")
func _ready():
	rangeAttackTimer.start()
	# need to instantiate the scene and put into the hierarchy
	# this means changed made to this instance, will persist until end of program  
#	var RANGED_ATTACK = rangedAttack.instantiate()
		
	#adding the child to the scene 
#	add_child(RANGED_ATTACK)
#	#we can do whatever we want with this instance 
#	RANGED_ATTACK.get_node("RangedAttackTimer").start()
	
#var abilities = {
#	'bubble' : preload("res://BubbleBullet.tscn")
#} 
#var bubble_attack = $BubbleAttack
#func _ready():
#	_upgrade('bubble')
#
#	_upgrade('bubble');
#func HasLeveled(experience):
#	return experience > maxExperience
#func AddAbility(ability):
#	if abilities.has(ability):
#		return false;

#func _upgrade(ability):
#	match ability:
#		'bubble':
#			if abilities.has('bubble'):
#				$Attack/BubbleAttackTimer.start()
#
#	match ability:
#		'bubble':
#			if abilities.has(ability):
#				pass
#			else:
#				print('bubble start timer')
#				abilities.append(ability)
#				print('bubble attack start timer')
##				$Attack/BubbleAttackTimer.start()
#
	
func _process(delta):
	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	"""
	might want varying types of movement
	"""
	# =========== swim movement/tank controls ==========
	if direction.x < 0:
		rotationAngle -= PI/180 * rotationSpeed * delta
	if direction.x > 0:
		rotationAngle += PI/180 * rotationSpeed * delta
	rotation = rotationAngle
	
	if rotationAngle < 0:
		rotationAngle = 2 * PI + rotationAngle;
	if rotationAngle > 2 * PI:
		rotationAngle = 2 * PI - rotationAngle;
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.stop()
	velocity = Vector2(-sin(rotation) * direction.y,cos(rotation) * direction.y) * moveSpeed;
	# ==========================================
#	print(currentExperience)
	
func _physics_process(delta):
	move_and_slide()


#func _on_bubble_attack_timer_timeout():
#	var bubble = abilities.get('bubble').instantiate()
#	bubble.global_position = global_position
#	bubble.velocity = Vector2(sin(rotation),-cos(rotation));
#	# Main is the parent. so just add bullets to Main by calling the parent of player and add
#	# bubble ad a child
#	# note: this is IF player is a child of main 
#	get_parent().add_child(bubble)

func gainexp(amount):
	currentExperience += amount 

#func _on_ranged_attack_timer_timeout():
##	print('range attack')
#	var rangeAttack = abilityDB["ranged"].instantiate()
#	rangeAttack.top_level = true
#	rangeAttack.position = position
#	rangeAttack.velocity = Vector2(sin(rotation),-cos(rotation))
##	rangeAttack.velocity = Vector2(1,1)
#	add_child(rangeAttack)

func _on_hurt_box_hurt(damage):
	hp -= damage 
	print('hp', hp)
	if hp <= 0:
		print('dead')
