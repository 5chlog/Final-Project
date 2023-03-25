extends StaticBody2D
class_name Door

export(String, FILE,  "*.tscn") var target_level_path = ""
export(Texture) var door_sprite = null

func _ready():
	if door_sprite != null:
		$Sprite.texture = door_sprite


func open_door():
	collision_layer = 0
	$Sprite.frame = 1


func _on_Area2D_body_entered(body):
	if target_level_path.empty() or $Sprite.frame == 0:
		return
	
	if body is Player:
		return get_tree().change_scene(target_level_path)
