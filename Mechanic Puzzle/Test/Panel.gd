extends Position2D

var index: int = 0
var UNIT_HEIGHT = 0
var comedown_animation: Animation = null
var comedown_pos_y_trackno = 0
var comedown_key_0: int = 0
var comedown_key_1: int = 1
onready var animationplayer = $AnimationPlayer


func _ready():
	animationplayer.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	
	# print(self, " position: ", position)
	# print("*************\n")


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if index > 0:
			animationplayer.play("Come Down")
		else:
			z_index = 0
			$Sprite.scale = Vector2(0.75, 0.75)
			animationplayer.play("Go Up")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Go Up":
		index = get_parent().panel_count - 1
		z_index = 1
		$Sprite.scale = Vector2(1, 1)
	elif anim_name == "Come Down":
		index = index - 1
	
	comedown_animation.track_set_key_value(comedown_pos_y_trackno, comedown_key_0, 
			-UNIT_HEIGHT * index)
	comedown_animation.track_set_key_value(comedown_pos_y_trackno, comedown_key_1, 
			-UNIT_HEIGHT * (index - 1))
	# print(self, " animation: ", anim_name)
	# print(self, " position: ", position, "\n*************\n")
