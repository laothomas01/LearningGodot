extends Node2D

enum { PLAY, PAUSE }

var state: int = PLAY:
	set(value):
		state = value
		match state:
			PLAY:
				pass
			PAUSE:
				handle_pause_state()
			
# @TODO might need to update this should code be scaled up 
# to communicate between player states and behavior of game manager 
func _ready():
	pass
#	var callable = Callable(player, "_on_player_leveled_up")
#	player.connect("lesfasdfasdf", callable)
#	player.connect("leveled_up", Callable(self, "_on_player_leveled_up").bind(player))
func handle_pause_state():
	pass
func handle_play_state():
	get_tree().paused = false

func on_level_up():
	print('level uasdsadasp')
#func _ready():
#	pass
#func _process(delta):
#	match current_state:
#		GameState.PLAY:
#			pass
#		GameState.PAUSE:
#			get_tree().paused= true
		

