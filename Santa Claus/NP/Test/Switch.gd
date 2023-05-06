extends Sprite

var platform = null
var child_display = null
var child = null

func interact():
	if platform == null:
		platform = get_node("../GiftSlots/GiftPlatform")
	
	if child_display == null:
		child_display = get_node("../ChildDisplay")
	
	child = child_display.children[child_display.index]
	
	
	if platform.placed_gift == null:
		if child.assigned_gift != null:
			var gift = child.remove_gift()
			platform.place_gift(gift)
		else:
			return
	else:
		if child.assigned_gift != null:
			var temp = platform.placed_gift 
			platform.place_gift(child.assigned_gift)
			child.assign_gift_to_child(temp)
		else:
			child.assign_gift_to_child(platform.placed_gift)
			platform.remove_gift()
	
	$InteractableArea.player.toggleHold()
