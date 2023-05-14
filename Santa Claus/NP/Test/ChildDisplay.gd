extends Node2D

var children = null
var extra_hud = null
var child_index:int = 0
var active:bool = false
var running:bool = false
var gifted_slots = null
var gift_index = -1
var null_sprite = preload("res://Santa Claus/Sprites/Null.png")

func prepare_display():
	extra_hud = get_node("/root/HUD/ExtraHUD")
	children = extra_hud.get_children_node()
	var threshold:int = children.threshold
	children = children.get_children()
	get_node("ChildSprite").texture = children[0].get_node("Sprite").texture
	
	set_child_to_selected()
	
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
		extra_hud.hide_full_display()
		$InteractableArea.enable()
		$InteractableArea.player.toggleHold()
	
	if Input.is_action_just_pressed("game_left"):
		#Child movement in full display
		set_child_back()
		child_index = ( child_index - 1 + children.size() ) % children.size()
		set_child_to_selected()
		get_node("ChildSprite").texture = children[child_index].get_node("Sprite").texture
		set_slot_values()
		reset_gift_display_and_selector()
		update_gifts_list()
		set_display_gift()
		
	elif Input.is_action_just_pressed("game_right"):
		#Child movement in full display
		set_child_back()
		child_index = ( child_index + 1 ) % children.size()
		set_child_to_selected()
		get_node("ChildSprite").texture = children[child_index].get_node("Sprite").texture
		set_slot_values()
		reset_gift_display_and_selector()
		update_gifts_list()
		set_display_gift()
		
	elif Input.is_action_just_pressed("game_up"):
		if gift_index != -1 :
			gifted_slots[gift_index].get_node("Highlight").visible = false
			gift_index = ( gift_index + 1 ) % gifted_slots.size()
			set_display_gift()
		
	elif Input.is_action_just_pressed("game_down"):
		if gift_index != -1 :
			gifted_slots[gift_index].get_node("Highlight").visible = false
			gift_index = ( gift_index - 1 + gifted_slots.size() ) % gifted_slots.size()
			set_display_gift()


func update_gifts_list():
	gifted_slots = children[child_index].get_gifted_slots()
	
	if gifted_slots == null :
		gift_index = -1
	else :
		gift_index = 0


func reset_gift_display_and_selector():
	if gifted_slots != null :
		gifted_slots[gift_index].get_node("Highlight").visible = false
		
	$Gift.texture = null_sprite


func set_display_gift():
	if gift_index != -1 :
		gifted_slots[gift_index].get_node("Highlight").visible = true
		$Gift.texture = gifted_slots[gift_index].placed_gift.texture
	else:
		reset_gift_display_and_selector()


func set_child_back():
	children[child_index].global_position = extra_hud.get_child_position(child_index).global_position
	for slot in children[child_index].get_node("GiftSlots").get_children():
		slot.visible = false
		if slot.placed_gift != null :
			slot.placed_gift.visible = false


func set_child_to_selected():
	children[child_index].global_position = extra_hud.get_selected_child_position().global_position
	for slot in children[child_index].get_node("GiftSlots").get_children() :
		slot.visible = true
		if slot.placed_gift != null :
			slot.placed_gift.visible = true


func interact():
	active = true
	extra_hud.show_full_display()
	$InteractableArea.disable()
