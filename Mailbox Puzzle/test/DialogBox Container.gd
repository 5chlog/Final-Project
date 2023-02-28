extends ColorRect

var player: Player = null
export(Resource) var dialogresource = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") and visible:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
