extends Node2D


func _ready():
	hide_full_display()


func get_children_node():
	return get_node("FullDisplay/FullDisplayBorder/ViewportContainer/Viewport/FullDisplay/Children")


func show_full_display():
	$FullDisplay.visible = true


func hide_full_display():
	$FullDisplay.visible = false
