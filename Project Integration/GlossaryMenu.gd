extends GridContainer


var menu_name = "Glossary Sections"

export(String, FILE,  "*.tscn") var theory_level_path = ""
export(String, FILE,  "*.tscn") var puzzles_level_path = ""


func _on_TheoryButton_pressed():
	if theory_level_path.empty():
		return
	
	get_tree().change_scene(theory_level_path)


func _on_PuzzlesButton_pressed():
	if puzzles_level_path.empty():
		return
	
	get_tree().change_scene(puzzles_level_path)
