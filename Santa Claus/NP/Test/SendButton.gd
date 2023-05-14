extends Sprite

var platform = null
var child_display = null
var child = null

func interact():
	var extraHUD =  get_node("/root/HUD/ExtraHUD")
	
	if platform == null:
		platform = get_node("../GiftSlots/GiftPlatform")
	
	if child_display == null:
		child_display = get_node("../ChildDisplay")
	
	child = child_display.children[child_display.child_index]
	
	
	if platform.placed_gift != null:
		if child.get_node("Gifts").get_child_count() < child.get_node("GiftSlots").get_child_count() :
			child.add_gift(platform.placed_gift)
			platform.remove_gift()
			child_display.update_gifts_list()
			child_display.set_display_gift()
	
	$InteractableArea.player.toggleHold()
