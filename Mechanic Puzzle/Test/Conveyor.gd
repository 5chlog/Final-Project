extends Node2D

const UNIT_HEIGHT = 32
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
		goup_animation.length = 1.0 * (panel_count - 1)
		var goup_pos_y_trackno = goup_animation.add_track(Animation.TYPE_VALUE)
		goup_animation.track_set_path(goup_pos_y_trackno, ".:position:y")
		goup_animation.track_insert_key(goup_pos_y_trackno, 0.0, 0)
		goup_animation.track_insert_key(goup_pos_y_trackno, goup_animation.length, 
				-UNIT_HEIGHT * (panel_count - 1))
		panel.animationplayer.add_animation("Go Up", goup_animation)
		
		var comedown_animation = Animation.new()
		panel.comedown_animation = comedown_animation
		comedown_animation.length = 1.0
		var comedown_pos_y_trackno = comedown_animation.add_track(Animation.TYPE_VALUE)
		panel.comedown_pos_y_trackno = comedown_pos_y_trackno
		comedown_animation.track_set_path(comedown_pos_y_trackno, ".:position:y")
		comedown_animation.track_insert_key(comedown_pos_y_trackno, 0.0, -UNIT_HEIGHT * panel.index)
		comedown_animation.track_insert_key(comedown_pos_y_trackno, 1.0, 
				-UNIT_HEIGHT * (panel.index - 1))
		panel.animationplayer.add_animation("Come Down", comedown_animation)
	
	# print("***********\n")
