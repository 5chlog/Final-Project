extends Button
class_name LevelButton


export(String, FILE,  "*.tscn") var target_level_path = ""


func start_level():
	if target_level_path.empty():
		return
	
	get_tree().change_scene(target_level_path)
