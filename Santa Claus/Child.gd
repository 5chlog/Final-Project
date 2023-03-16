extends KinematicBody2D

onready var animation = $AnimationPlayer

func _ready():
	pass # Replace with function body.


func _process(delta):
	animation.play("Idle")
