extends Node2D

const UNIT_HEIGHT = 32
const UNIT_TIME = 0.5
export(int) var panel_count = 0
var bottom_panel = null

func _ready():
	panel_count = get_child_count()
	for i in panel_count:
		var panel = get_child(i)
		
		panel.index = i
		if i == 0:
			panel.z_index = 0
			bottom_panel = panel
		panel.UNIT_HEIGHT = UNIT_HEIGHT
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
		var shrink_scale_trackno = shrink_animation.add_track(Animation.TYPE_VALUE)
		shrink_animation.track_set_interpolation_type(shrink_scale_trackno, 
				Animation.INTERPOLATION_CUBIC)
		shrink_animation.track_set_path(shrink_scale_trackno, "./Sprite:scale")
		shrink_animation.track_insert_key(shrink_scale_trackno, 0.0, Vector2(1.0, 1.0))
		shrink_animation.track_insert_key(shrink_scale_trackno, UNIT_TIME, Vector2(0.75, 0.75))
		panel.animationplayer.add_animation("Shrink", shrink_animation)
		
		var expand_animation = Animation.new()
		expand_animation.length = UNIT_TIME
		var expand_scale_trackno = expand_animation.add_track(Animation.TYPE_VALUE)
		expand_animation.track_set_interpolation_type(expand_scale_trackno, 
				Animation.INTERPOLATION_CUBIC)
		expand_animation.track_set_path(expand_scale_trackno, "./Sprite:scale")
		expand_animation.track_insert_key(expand_scale_trackno, 0.0, Vector2(0.75, 0.75))
		expand_animation.track_insert_key(expand_scale_trackno, UNIT_TIME, Vector2(1.0, 1.0))
		panel.animationplayer.add_animation("Expand", expand_animation)
	
	# print("***********\n")
