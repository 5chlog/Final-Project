extends Area2D

onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/gift1.png")

func _ready():
	$Sprite.texture = sprite
	pass # Replace with function body.


func _process(delta):
	animation.play("Idle")
