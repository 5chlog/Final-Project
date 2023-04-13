extends Area2D

const GiftClass = preload("res://Santa Claus/Gift.gd")
const Gifts = preload("res://Santa Claus/Gifts.gd")
var gifts : Gifts
var player
var assigned_gift = null
export var child_index = -1
onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/Child1.png")

func _ready():
	$Sprite.texture = sprite
	pass # Replace with function body.
	
#func _input(event):
	#if event.is_action_pressed("ui_accept"):
		#assign_gift_to_child(gifts.selected_gift)
	
#func assign_gift_to_child(gift: GiftClass):
	#if gift.is_picked_up:
		#gift.is_picked_up = false
		#gift.position = position - Vector2(0,32)
		#assigned_gift = gift
	
func _process(delta):
	animation.play("Idle")
	
func interact():
	if gifts.selected_gift.is_picked_up:
		player = $InteractableArea.player
		player.toggleHold()
		$InteractableArea.disable()
		gifts.selected_gift.is_picked_up = false
		gifts.selected_gift.position = position - Vector2(0, 32)
		assigned_gift = gifts.selected_gift
		gifts.selected_gift = null
		
