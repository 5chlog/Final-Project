extends Node2D


var extra_hud_scene = preload("res://Mechanic Puzzle/Verification/Test/ExtraHUD.tscn")


func _ready():
	var extra_hud = extra_hud_scene.instance()
	HUD.add_child(extra_hud)
	extra_hud.visible = false
