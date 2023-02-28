extends Node

var active: bool = false
var player = null
onready var animatedPlayer = $InteractableArea/AnimatedSprite

func interact():
	animatedPlayer.play("TurningOn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	animatedPlayer.animation = "On"
	animatedPlayer.playing = false
	get_node("/root/World/Player").toggleHold()
