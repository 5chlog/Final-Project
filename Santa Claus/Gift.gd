extends Node2D

onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/gift1.png")
var is_picked_up = false
var player

func _ready():
	$Sprite.texture = sprite
	$Sprite.offset = -sprite.get_size() / 2
	animation.play("Idle")


func _physics_process(delta):
	if is_picked_up:
		position = player.position - Vector2(0, 32)

func interact():
	player = $InteractableArea.player
	player.toggleHold()
	$InteractableArea.disable()
	position = player.position - Vector2(0, 32)
	is_picked_up = true
	get_parent().selected_gift = self
