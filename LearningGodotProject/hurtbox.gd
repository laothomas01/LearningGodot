"""
- reusable script for handling damage upon collision via movement 
"""

extends Area2D


signal hurt(damage)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	var damage = area.damage 
	emit_signal("hurt",damage)
	
