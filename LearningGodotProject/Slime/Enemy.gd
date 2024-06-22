extends CharacterBody2D
@onready var character = get_node("/root/Main/Player")
@export var movement_speed = 40.0

signal hurt(damage)

func _ready():
	pass
	
func _process(delta):
	var direction = global_position.direction_to(character.global_position)
	velocity = direction * movement_speed
	move_and_slide()

func _on_hurtbox_area_entered(area):
	var damage = area.damage
	emit_signal("hurt",damage)	
