extends Node2D


func _ready():
	hide_full_display()


func get_children_node():
	return get_node("FullDisplay/FullDisplayBorder/ViewportContainer/Viewport/FullDisplay/Children")
	

func get_selected_child_position():
	return get_node("FullDisplay/FullDisplayBorder/ViewportContainer/Viewport/FullDisplay/SelectedChild")


func get_child_position(var index:int):
	return get_node("FullDisplay/FullDisplayBorder/ViewportContainer/Viewport/FullDisplay/ChildPositions/PChild" + String(index+1))


func show_full_display():
	$FullDisplay.visible = true


func hide_full_display():
	$FullDisplay.visible = false
