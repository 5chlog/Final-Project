extends Node2D


var sad_sprite = preload("res://Santa Claus/Sprites/Sad.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Idle")


func interact():
	$AnimationPlayer.play("Give Gift")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Give Gift":
		$InteractableArea.player.toggleHold()
		$AnimationPlayer.play("Idle")
