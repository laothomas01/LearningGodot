extends Area2D


var damage = 1
#@onready var character = get_tree().get_first_node_in_group("character")
## Called when the node enters the scene tree for the first time.
#func _ready():
#	# will currently have close combat attack just attack from one side 
#	global_position = character.global_position + Vector2(5"top_level"z0 * character.transform_adjustment.scale.x * 1.1,0)
## Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var character = get_tree().get_first_node_in_group("character")
func _process(delta):
			global_position = character.global_position + Vector2(40 * character.transform2D.scale.x,0)

func _on_life_span_timeout():
	
	queue_free()
