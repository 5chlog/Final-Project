extends Sprite

var index: int = 0
var UNIT_HEIGHT = 0
var comedown_animation: Animation = null
var comedown_pos_y_trackno = 0
var comedown_key_0: int = 0
var comedown_key_1: int = 1
onready var animationplayer = $AnimationPlayer


func _ready():
	animationplayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	z_index = 1


func _activate():
	if index > 0:
		animationplayer.play("Come Down")
	else:
		z_index = 0
		animationplayer.play("Go In")
		for child in get_children():
			if child is MachineObject:
				child.get_node("InteractableArea").disable()
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Go In":
		animationplayer.play("Go Up")
		return
	elif anim_name == "Go Up":
		index = get_node("../..").panel_count - 1
		z_index = 1
		animationplayer.play("Come Out")
	elif anim_name == "Come Down":
		index = index - 1
		if index == 0:
			for child in get_children():
				if child is MachineObject:
					child.get_node("InteractableArea").enable()
			get_node("../..").bottom_panel = self
	elif anim_name == "Come Out":
		var parent = get_node("../..")
		parent.off = true
		parent.player.toggleHold()
		parent.switch.get_node("InteractableArea").enable()
		parent.switch.frame = 0
	
	comedown_animation.track_set_key_value(comedown_pos_y_trackno, comedown_key_0, 
			-UNIT_HEIGHT * index)
	comedown_animation.track_set_key_value(comedown_pos_y_trackno, comedown_key_1, 
			-UNIT_HEIGHT * (index - 1))
