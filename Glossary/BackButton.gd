extends Button


export(String, FILE,  "*.tscn") var main_menu_path = ""


func _on_BackButton_pressed():
	if main_menu_path.empty():
		return
	
	get_tree().change_scene(main_menu_path)
