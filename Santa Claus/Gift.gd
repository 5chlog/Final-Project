extends Node2D

onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/gift1.png")
export var gift_index = -1
var is_picked_up = false
var player
var initial_position

func _ready():
	$Sprite.texture = sprite
	$Sprite.offset = -sprite.get_size() / 2
	animation.play("Idle")
	initial_position = position


func _physics_process(delta):
	if is_picked_up:
		position = player.position - Vector2(0, 32)

func _input(event):
	if event.is_action_pressed("game_back") and is_picked_up:
		is_picked_up = false
		position = initial_position
		
	#if event.is_action_pressed("ui_accept") and is_picked_up:
		#is_picked_up = false
	
func interact():
	player = $InteractableArea.player
	player.toggleHold()
	$InteractableArea.disable()
	position = player.position - Vector2(0, 32)
	is_picked_up = true
	get_parent().selected_gift = self
