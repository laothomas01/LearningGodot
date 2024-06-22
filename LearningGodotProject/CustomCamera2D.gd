extends Camera2D
# Target node the camera is following 
#@export var TargetNode : Node2D = null
var targetNode : Node2D = null 
# Called when the node enters the scene tree for the first time.
func _ready():
	targetNode = get_node("/root/Main/Player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = targetNode.position # Change this code to make custom camera movement 
#	print(targetNode.position)
	
	
