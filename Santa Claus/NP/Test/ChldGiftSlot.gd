extends Node2D

var placed_gift = null
export (Vector2) var offset 
export (NodePath) var gift_path = null


func _ready():
	$Gift.position += offset
	$FirstDigitSprite.position += offset
	$SecondDigitSprite.position += offset
	
	if gift_path != null:
		place_gift(get_node(gift_path))
		placed_gift.player = get_node("../../Player")
		
	set_slotted_gift_value()

func set_slotted_gift_value():
	if placed_gift == null:
		$FirstDigitSprite.frame = 10 
		$SecondDigitSprite.frame = 10
	else:
		var child_index:int = get_node("../../").child_index
		var gift_value:int = placed_gift.gift_values[child_index]
		$FirstDigitSprite.frame = (gift_value/10) % 10 
		$SecondDigitSprite.frame = gift_value % 10


func place_gift(var gift):
	placed_gift = gift
	placed_gift.global_position = $Gift.global_position
	#$Gift.add_child(placed_gift)
	gift.is_picked_up = false
	set_slotted_gift_value()

func remove_gift():
	var gift = placed_gift
	placed_gift = null
	set_slotted_gift_value()
	return gift
