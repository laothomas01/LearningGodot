extends Node2D


"""
same concept applies to other "ITEMS" as this should be classified as 
- Food/Heal
- Currency/Coin 

Layer: ItemHurtbox 
Mask: CollectionHitbox 

on area_enetered:
		queue_free
		
		
"""

@export var exp = 2
var item_name = "gem"
func _on_area_entered(area):
	print('Being collected by ', area.name)
	queue_free()
