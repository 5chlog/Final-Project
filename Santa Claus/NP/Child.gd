extends Area2D

var threshold = 0
var assigned_gift = null
export var child_index = -1
onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/Child1.png")


func update_threshold():
	if assigned_gift == null :
		$Indicator.frame = 1
		$Indicator/FirstDigitSprite.frame = 0
		$Indicator/SecondDigitSprite.frame = 0
	else:
		var happiness:int = assigned_gift.gift_values[child_index]
		if happiness >= threshold :
			$Indicator.frame = 0
			$Indicator/FirstDigitSprite.frame = (happiness/10) % 10 
			$Indicator/SecondDigitSprite.frame = happiness % 10
		else:
			$Indicator.frame = 1
			$Indicator/FirstDigitSprite.frame = (happiness/10) % 10 
			$Indicator/SecondDigitSprite.frame = happiness % 10


func _ready():
	$Sprite.texture = sprite
	$Indicator.frame = 1
	animation.play("Idle")


func assign_gift_to_child(var gift):
		gift.global_position = $Gift.global_position
		assigned_gift = gift
		update_threshold()


func remove_gift():
		assigned_gift =  null
		update_threshold()
