extends Area2D
"""
- when a hurtbox interacts with a hitbox, 
an output will occur for the owner of the hurtbox 

"""

signal hurt(damage)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

"""
Area2D:

Category(s):
	N/A
Interaction:
	Player

"""
func _on_area_entered(area):
		print(area)
