extends Area2D

"""
Collision hitbox 
- upon colliding with a player, deal X damage to player 
	- disable hitbox for N amount of time
"""

@export var damage = 1
@onready var collision = $CollisionShape2D
@onready var timer = $DisableTImer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



