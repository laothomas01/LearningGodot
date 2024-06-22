extends CharacterBody2D

@export var movement_speed = 80
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var character = get_tree().get_first_node_in_group("character") 
var maxhealth = 1.0
var health = maxhealth
var target = Vector2.ZERO

func _ready():
	pass
func _physics_process(delta):
	var move_direction = global_position.direction_to(character.global_position)
	velocity = move_direction * movement_speed
	
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
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


func _on_enemy_hurt_box_hurt(damage):
	health -= damage
#	print(name,"Current Health:",health)
	
	if health <= 0:
		character
		queue_free()
