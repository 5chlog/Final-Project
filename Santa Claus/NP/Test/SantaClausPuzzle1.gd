extends Node2D

# Initial values
var number_of_children = 0
var number_of_gifts = 0
var submitted = false

func _ready():
	pass 

func _process(delta):
	pass

# Player interacts with gifts, gifts follow player
# Player then interacts with child, gift will be near child, values will be updated
# Player interacts with gift near child, gift again follows player
# Player presses release button, gift moves back to original position
# Player goes near child and player doesn't have gift, child happiness is displayed
# If child happiness is displayed and past threshold, display as green, else red