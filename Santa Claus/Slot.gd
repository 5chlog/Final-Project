extends Node2D


var placed_gift = null
export (Vector2) var offset 
export (NodePath) var gift_path = null


func _ready():
	$Gift.position += offset
	if gift_path != null:
		placed_gift = get_node(gift_path)
		place_gift(placed_gift)
		placed_gift.player = get_node("../../Player")


func place_gift(var gift):
	placed_gift = gift
	placed_gift.global_position = $Gift.global_position
	gift.is_picked_up = false

func interact():
	$InteractableArea.player.toggleHold()
	var gifts = get_node("../../Gifts")
	
	if placed_gift == null and gifts.selected_gift != null:
		place_gift(gifts.selected_gift)
		gifts.selected_gift = null
		
	elif placed_gift != null and gifts.selected_gift != null:
		var temp = gifts.selected_gift
		placed_gift.pickup()
		place_gift(temp)
		
	elif placed_gift != null:
		placed_gift.pickup()
		placed_gift = null
