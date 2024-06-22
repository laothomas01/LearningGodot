extends Node2D


#
#var player
#var spawnCount 
## Called when the node enters the scene tree for the first time.

var waveCount = 0
var customCamera2D
var cameraViewPort
func _ready():
	customCamera2D = get_node("/root/Main/CustomCamera2D")
	cameraViewPort = customCamera2D.get_viewport_rect()
	
	
#	print(cameraViewPort)
#		player = get_node("/root/Main/Player")
	$SpawnTime.start()
	$WaveTime.start()
#		spawnCount = 0
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	waveTimer += 1
#	print(waveTimer)
#	if fmod(waveTimer,1200) == 0:
#		waveTimer = 0
#		waveCount += 1
		
#	pass
#
#"""
#
#- load an enemy scene
#- set its position a distance away from the player's
#
#"""
#func _on_spawn_time_timeout():
##		if(spawnCount < 2):
##			var mob = preload("res://Enemy.tscn").instantiate()
##			#fix this variable later
##			mob.global_position = Vector2(player.global_position.x * tempDistance,player.global_position.y * tempDistance)
##			get_parent().add_child(mob)
##			spawnCount += 1
##		else:
##			return
#
#	var mob = preload("res://Enemy.tscn").instantiate()
#			#fix this variable later
#	mob.global_position = Vector2(player.global_position.x * 5,player.global_position.y * 5)
#	get_parent().add_child(mob)
#
#



func _on_spawn_time_timeout():
#	print(screen_size)
#	print(screen_size.position)
#	print(screen_size.end)
#	var player = get_node("/root/Main/Player")
	var mob = preload("res://Slime/Slime.tscn").instantiate()
#	mob.position = Vector2(randf_range(screen_size.position.x,screen_size.end.x),randf_range(screen_size.position.y,screen_size.end.y))
#	print(mob.position)
	mob.top_level = true
	add_child(mob)
	
func _on_wave_time_timeout():
	waveCount += 1
