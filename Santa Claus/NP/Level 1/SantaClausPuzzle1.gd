extends Node2D

# Initial values
export(bool) var has_solution = true
export(bool) var final_level = false

var extra_hud_scene = preload("res://Santa Claus/NP/Test/ExtraHUD.tscn")

func _ready():
	var extra_hud = extra_hud_scene.instance()
	HUD.add_child(extra_hud)
	$ChildDisplay.prepare_display()


# Player interacts with gifts, gifts follow player
# Player then interacts with child, gift will be near child, values will be updated
# Player interacts with gift near child, gift again follows player
# Player presses release button, gift moves back to original position
# Player goes near child and player doesn't have gift, child happiness is displayed
# If child happiness is displayed and past threshold, display as green, else red
