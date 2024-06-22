extends CharacterBody2D

"""

a more specialized slime 
	- tougher than basic slime
	- weaker than big slime
	- can split in 2 after death 
- will implement an attack animation and state later
attributes:
	- more health
	- slightly more attack damage 
	- slightly slower speed than regular slime 
	
"""



@export var movement_speed = 1
@export var damage = 3
@onready var character = get_tree().get_first_node_in_group("character") 
@onready var animation = $TransformAdjustment/AnimatedSprite2D
@onready var hit_box = $HitBox

var exp_gem = preload("res://TestScene3/Scenes/Gem.tscn")

enum {
	IDLE,
	WALK,
	DEATH,
	DAMAGE
}

var state: int = WALK:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			WALK:
				walk_state()
			DEATH:
				death_state()
			DAMAGE:
				damage_state()
			
@export var maxhealth = 1.0
var health = maxhealth

func _ready():
	hit_box.damage = damage
	state = WALK
	
func _process(delta):
#	print(state)
	if state != DAMAGE :
				state = WALK if velocity.length_squared() > 0 else IDLE
	var move_direction = global_position.direction_to(character.global_position)
	velocity = move_direction * movement_speed * delta
			
func _physics_process(delta):
	move_and_slide()

func idle_state():
#	animation.play("IdleOrMove")
	pass
func walk_state():
#	print("walk state")
	animation.play("IdleOrMove")
func damage_state():
	if health <= 0:
		animation.play("Death")
		await animation.animation_finished
		state = DEATH
	else:
#		print("damage state")
		animation.play("TakeDamage")
		await animation.animation_finished
		state = WALK
#	if health <= 0:
#		pass
#	else:
#		animation.play("TakeDamage")
#		await animation.animation_finished
#		state = WALK

"""
do something when the entity dies 
ex: drop gems, explode, do something on death 

figure out how to create a death counter for player 

"""
func death_state():
	for i in range(2):
		var basic_slime = preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn").instantiate()
		basic_slime.global_position = global_position + Vector2(10,10) * i
		get_parent().add_child(basic_slime)
	queue_free()
	"""
	slime splits into 2 weaker slimes 
	"""
#	for i in range(10):
#			var basic_slime = preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn").instantiate()
#			basic_slime.global_position = Vector2(i,i)
#			get_parent().add_child(basic_slime)
#	queue_free()
"""
might need an alternative to enums but this is how we will handle states for now 

"""



"""
callback function for taking damage signals 
"""

func _on_hurt_box_hurt(damage):
# ============================== 
# 	keep this block of code  
	health -= damage
	state = DAMAGE
# ===============================



#	print(name," receiving damage amount:",damage)
#	if health <= 0:
#		var new_gem = exp_gem.instantiate()
#		new_gem.global_position = global_position
#		get_parent().add_child(new_gem)
#		queue_free()
		
		


