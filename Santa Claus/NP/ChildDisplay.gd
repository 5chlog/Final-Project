extends Node2D

var children = null 
var index:int = 0
var active:bool = false
var running:bool = false


func _ready():
	children = get_node("../Children").get_children()
	get_node("ChildSprite").texture = children[0].get_node("Sprite").texture
	
	var threshold:int = get_node("../Children").threshold
	$FirstDigitSprite.frame = (threshold/10) % 10 
	$SecondDigitSprite.frame = threshold % 10


func set_slot_values():
	for slot in get_node("../GiftSlots").get_children():
		slot.set_slotted_gift_value()


func _input(_event):
	if not active or running:
		return
	
	if Input.is_action_just_pressed("game_back"):
		active = false
		$InteractableArea.enable()
		$InteractableArea.player.toggleHold()
	
	if Input.is_action_just_pressed("game_left"):
		index = ( index - 1 + children.size() ) % children.size()
		get_node("ChildSprite").texture = children[index].get_node("Sprite").texture
		set_slot_values()
		
	elif Input.is_action_just_pressed("game_right"):
		index = ( index + 1 ) % children.size()
		get_node("ChildSprite").texture = children[index].get_node("Sprite").texture
		set_slot_values()
		
func interact():
	active = true
	$InteractableArea.disable()
