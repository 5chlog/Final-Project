extends StaticBody2D

export(String, FILE,  "*.tscn") var target_level_path = ""

func _on_Area2D_body_entered(body):
	if target_level_path.empty() : return
	
	if body is Player:
		return get_tree().change_scene(target_level_path)
