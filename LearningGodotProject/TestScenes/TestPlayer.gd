extends CharacterBody2D

#
const SPEED = 200.0
var hp = 80
var bubble_attack_level = 0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var bubble_timer = get_node("Attack/BubbleTimer")
@onready var bubble_attack_timer = get_node("Attack/BubbleTimer/BubbleAttackTimer")
#Attacks 
var attacks_preload = { 
	"bubble_attack" : preload("res://TestScenes/BubbleAttack.tscn")
}
var collected_upgrades = []
var enemy_close = []
func _ready():
	upgrade_character("bubble_attack")
	bubble_timer.start()
func _physics_process(delta):
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		print(direction)
		velocity = Vector2(direction.x,direction.y) * SPEED
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += graSvity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()


#func _on_hurtbox_hurt(damage):
#	print('enemy damage:',damage)
#	hp -= damage
#	print('player health: ',hp)
#	if hp <= 0:
#		death() 
#func death():
#	print('dead')

func upgrade_character(upgrade):
	match upgrade:
		"bubble_attack":
			bubble_attack_level = 1
		
	collected_upgrades.append(upgrade)
	

func _on_hurtbox_hurt(damage):
	pass
#	print('player took damage:',damage)

func _on_bubble_timer_timeout():
	bubble_attack_timer.start()

func _on_bubble_attack_timer_timeout():
	var bubble_attack = attacks_preload["bubble_attack"].instantiate()
	bubble_attack.position = position
#	bubble_attack.position = position
	bubble_attack.target = get_random_target()
	bubble_attack.level = bubble_attack_level
	add_child(bubble_attack)

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP
		
func _on_enemy_detection_area_body_entered(body):
#	pass
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
#	pass
	if enemy_close.has(body):
		enemy_close.erase(body)


