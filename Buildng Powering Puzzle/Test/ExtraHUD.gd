extends CanvasLayer

onready var animationplayer: AnimationPlayer = get_node("AnimationPlayer")


func _ready():
	visible = true
	$SelectCount/SelectCountLabel.text = "0/" + String(get_node("../GeneratorSwitches").selectable_count)


func show_select_count():
	animationplayer.play("Show Select Count")


func hide_select_count():
	animationplayer.play("Hide Select Count")
