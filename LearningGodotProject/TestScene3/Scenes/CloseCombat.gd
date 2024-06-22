extends Node2D

@export var cooldown = 1
@export var damage = 1
@export var lifespan = 1
@onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed times since the previous frame.
func _process(delta):
	pass

func start_timer():
	timer.start()
func _on_attack_timer_timeout():
		var melee = preload("res://TestScene3/Scenes/Abilities/Melee.tscn").instantiate()
		add_child(melee)
		
		
