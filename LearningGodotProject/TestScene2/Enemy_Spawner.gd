extends Node2D

@onready var character = get_tree().get_first_node_in_group("character")
@onready var spawnTimer = get_node("Timer")
var max_distance = 1450  
func _ready():
	spawnTimer.start()
	
func get_random_position():
	var viewport = get_viewport_rect().size * 1.1
	
	# the spawn postions are the viewport corners offset from the player's position 
	var top_left = Vector2(character.global_position.x - viewport.x / 2, character.global_position.y - viewport.y / 2)
	var top_right = Vector2(character.global_position.x + viewport.x / 2, character.global_position.y - viewport.y / 2)
	var bottom_left = Vector2(character.global_position.x - viewport.x / 2, character.global_position.y + viewport.y / 2)
	var bottom_right = Vector2(character.global_position.x + viewport.x / 2, character.global_position.y + viewport.y / 2)
	
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)
	
func spawn():
	# for testing purposes 
	var enemy_spawn = preload("res://TestScene2/TestEnemy.tscn").instantiate()
	enemy_spawn.global_position = get_random_position()
	add_child(enemy_spawn)

# upon timeout, spawn entity 
func _on_timer_timeout():
	spawn()
