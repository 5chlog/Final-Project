extends Node2D


export(bool) var has_solution = true
export(bool) var final_level = false
var extra_hud_scene = preload("res://Buildng Powering Puzzle/Test/NP/ExtraHUD.tscn")

func _ready():
	var extra_hud = extra_hud_scene.instance()
	HUD.add_child(extra_hud)
	
	HUD.get_node("ExtraHUD/AnimationPlayer").connect("animation_finished", get_node("Owner"), 
			"_on_animation_finished")
	
