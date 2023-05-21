extends Sprite

var platform = null
var child_display = null
var child = null

func interact():
	if platform == null:
		platform = get_node("../GiftSlots/GiftPlatform")
	
	if child_display == null:
		child_display = get_node("../ChildDisplay")
	
	child = child_display.children[child_display.child_index]
	
	if child_display.gifted_slots != null:
		var slot = child_display.gifted_slots[child_display.gift_index]
		var gift = child.remove_gift(slot)
		var free_slot = get_node("/root/Level/GiftSlots").get_free_slot()
		free_slot.place_gift(gift)
		child_display.reset_gift_display_and_selector()
		child_display.update_gifts_list()
		child_display.set_display_gift()
		
	$InteractableArea.player.toggleHold()
