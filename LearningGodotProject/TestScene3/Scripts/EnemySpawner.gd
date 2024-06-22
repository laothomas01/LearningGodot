extends Node2D

@onready var character = get_tree().get_first_node_in_group("character")
@onready var spawnTimer = get_node("EnemySpawnTimer")
@onready var newWaveTimer = get_node("NewWaveTimer")


var currentWave = 1
"""

could possible make the value of the key an array so you have multiple enemies spawning inside the current wave 

approaches to changing enemy waves:
	- every 30 seconds, a new wave?

we can buff the enemies to be tougher as each wave progresses  

maybe we can have a randomized enemy spawn pick based on the current wave count? 

"""
var enemyWaves = {
	1 : 	 preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn"),
	2: 		 preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn"),
	3: 		 preload("res://TestScene3/Scenes/Enemies/Enemy1.tscn"),
}


# Called when the node enters the scene tree for the first time.
func _ready():
		spawnTimer.start()
		newWaveTimer.start()
func _process(delta):
	"""
	what if we reached max number of enemy waves??? 
	"""
	if currentWave > 3:
		currentWave = 1
		
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
#	# for testing purposes 
	var enemy_spawn = enemyWaves[currentWave].instantiate()
	enemy_spawn.global_position = get_random_position()
	add_child(enemy_spawn)

"""
	general function used to spawn enemies every so seconds 
"""
func _on_enemy_spawn_time_timeout():
	spawn()

"""
	every N seconds, we start a new wave 
"""
func _on_new_wave_timer_timeout():
#	print("Current Wave:", currentWave)
	currentWave += 1
	
	
	
