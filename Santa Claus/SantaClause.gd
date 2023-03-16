extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	animation.play("Idle")
