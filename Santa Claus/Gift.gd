extends Sprite

onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/gift1.png")
export var gift_index = -1
var is_picked_up = false
var player = null

func _ready():
	texture = sprite
	animation.play("Idle")


func _physics_process(delta):
	if is_picked_up:
		position = player.position - Vector2(0, 32)


func pickup():
	position = player.position - Vector2(0, 32)
	is_picked_up = true
	get_parent().selected_gift = self
