extends Node2D


export(int) var initial_value = 100


func _ready():
	visible = false
	set_value(initial_value)


func show():
	if not visible:
		$AnimationPlayer.play("Slide In")


func hide():
	if visible:
		$AnimationPlayer.play("Slide Out")


func increase(var increment: int):
	$ValueLabel.text = (($ValueLabel.text as int) + increment) as String


func set_value(var value: int):
	$ValueLabel.text = value as String
