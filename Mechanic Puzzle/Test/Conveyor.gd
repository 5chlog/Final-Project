extends Node2D

const UNIT_HEIGHT = 42
const UNIT_TIME = 0.5
const SHRINK_FACTOR = 0.75

export(int) var selectable_object_count = 1
var selected_object_count: int = 0

var bottom_panel = null
var off: bool = true
var player: Player = null
var switch = null

func _ready():
	var panel_count = get_child_count()
	for i in panel_count:
		var panel = get_child(i)
		
		panel.index = i
		if i == 0:
			panel.z_index = 0
			bottom_panel = panel
		for child in panel.get_children():
			if child is MachineObject:
				child.get_node("InteractableArea").disable()
		
		panel.UNIT_HEIGHT = UNIT_HEIGHT
		panel.position.y = -UNIT_HEIGHT * i
		# print(panel, " index: ", panel.index)
		
		var goup_animation = Animation.new()
		goup_animation.length = UNIT_TIME * (panel_count - 1)
		var goup_pos_y_trackno = goup_animation.add_track(Animation.TYPE_VALUE)
		goup_animation.track_set_interpolation_type(goup_pos_y_trackno, 
				Animation.INTERPOLATION_CUBIC)
		goup_animation.track_set_path(goup_pos_y_trackno, ".:position:y")
		goup_animation.track_insert_key(goup_pos_y_trackno, 0.0, 0)
		goup_animation.track_insert_key(goup_pos_y_trackno, goup_animation.length, 
				-UNIT_HEIGHT * (panel_count - 1))
		panel.animationplayer.add_animation("Go Up", goup_animation)
		
		var comedown_animation = Animation.new()
		panel.comedown_animation = comedown_animation
		comedown_animation.length = UNIT_TIME
		var comedown_pos_y_trackno = comedown_animation.add_track(Animation.TYPE_VALUE)
		panel.comedown_pos_y_trackno = comedown_pos_y_trackno
		comedown_animation.track_set_interpolation_type(comedown_pos_y_trackno, 
				Animation.INTERPOLATION_CUBIC)
		comedown_animation.track_set_path(comedown_pos_y_trackno, ".:position:y")
		comedown_animation.track_insert_key(comedown_pos_y_trackno, 0.0, -UNIT_HEIGHT * panel.index)
		comedown_animation.track_insert_key(comedown_pos_y_trackno, UNIT_TIME, 
				-UNIT_HEIGHT * (panel.index - 1))
		panel.animationplayer.add_animation("Come Down", comedown_animation)
		
		var shrink_animation = Animation.new()
		shrink_animation.length = UNIT_TIME
		# var shrink_scale_trackno = shrink_animation.add_track(Animation.TYPE_VALUE)
		# shrink_animation.track_set_interpolation_type(shrink_scale_trackno, 
		# 		Animation.INTERPOLATION_CUBIC)
		# shrink_animation.track_set_path(shrink_scale_trackno, "./Sprite:scale")
		# shrink_animation.track_insert_key(shrink_scale_trackno, 0.0, Vector2(1.0, 1.0))
		# shrink_animation.track_insert_key(shrink_scale_trackno, UNIT_TIME, 
		# 		Vector2(SHRINK_FACTOR, SHRINK_FACTOR))
		var shrink_modulate_a_trackno = shrink_animation.add_track(Animation.TYPE_VALUE)
		shrink_animation.track_set_interpolation_type(shrink_modulate_a_trackno, 
				Animation.INTERPOLATION_CUBIC)
		shrink_animation.track_set_path(shrink_modulate_a_trackno, ".:modulate:a")
		shrink_animation.track_insert_key(shrink_modulate_a_trackno, 0, 1)
		shrink_animation.track_insert_key(shrink_modulate_a_trackno, UNIT_TIME, 0.2)
		panel.animationplayer.add_animation("Go In", shrink_animation)
		
		var expand_animation = Animation.new()
		expand_animation.length = UNIT_TIME + 0.1
		# var expand_scale_trackno = expand_animation.add_track(Animation.TYPE_VALUE)
		# expand_animation.track_set_interpolation_type(expand_scale_trackno, 
		# 		Animation.INTERPOLATION_CUBIC)
		# expand_animation.track_set_path(expand_scale_trackno, "./Sprite:scale")
		# expand_animation.track_insert_key(expand_scale_trackno, 0.0, 
		# 		Vector2(SHRINK_FACTOR, SHRINK_FACTOR))
		# expand_animation.track_insert_key(expand_scale_trackno, UNIT_TIME, Vector2(1.0, 1.0))
		var expand_modulate_a_trackno = expand_animation.add_track(Animation.TYPE_VALUE)
		shrink_animation.track_set_interpolation_type(expand_modulate_a_trackno, 
				Animation.INTERPOLATION_CUBIC)
		expand_animation.track_set_path(expand_modulate_a_trackno, ".:modulate:a")
		expand_animation.track_insert_key(expand_modulate_a_trackno, 0, 0.2)
		expand_animation.track_insert_key(expand_modulate_a_trackno, UNIT_TIME, 1)
		panel.animationplayer.add_animation("Come Out", expand_animation)
	
	# print("***********\n")


func activate():
	if not off:
		return
	
	for panel in get_children():
		panel._activate()
