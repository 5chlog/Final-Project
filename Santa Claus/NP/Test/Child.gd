extends Area2D

var threshold = 0
var happiness = 0
var assigned_gift = null
export var child_index = -1
var selected_gift_index = -1
onready var animation = $AnimationPlayer
export(Texture) var sprite = preload("res://Santa Claus/Sprites/Child1.png")

func update_threshold():
	if $Gifts.get_child_count() == null :
		$Indicator.frame = 1
		$Indicator/FirstDigitSprite.frame = 0
		$Indicator/SecondDigitSprite.frame = 0
	else:
		happiness = 0
		for gift in $Gifts.get_children() :
			happiness += gift.gift_values[child_index]
		
		if happiness >= threshold :
			$Indicator.frame = 0
		else:
			$Indicator.frame = 1
		$Indicator/FirstDigitSprite.frame = (happiness/10) % 10 
		$Indicator/SecondDigitSprite.frame = happiness % 10


func _ready():
	for slot in $GiftSlots.get_children() :
		slot.visible = false
		
	$Sprite.texture = sprite
	$Indicator.frame = 1
	animation.play("Idle")


func add_gift(var gift):
	gift.get_parent().remove_child(gift)
	$Gifts.add_child(gift)
	gift.position = Vector2(0,0)
	var slot = get_free_slot()
	slot.place_gift(gift)
	update_threshold()


func get_gifted_slots():
	var list = []
	for slot in $GiftSlots.get_children():
		if slot.placed_gift != null :
			list.append(slot)
	if list.empty() :
		return null
	return list


func get_free_slot():
	for slot in $GiftSlots.get_children():
		if slot.placed_gift == null :
			return slot


func remove_gift(var slot):
	var gift = slot.remove_gift()
	$Gifts.remove_child(gift)
	get_node("/root/Level/Gifts").add_child(gift)
	update_threshold()
	return gift
