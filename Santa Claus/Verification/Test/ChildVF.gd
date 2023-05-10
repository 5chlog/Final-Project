extends Node2D

var checked:bool = false
var sad_sprite = preload("res://Santa Claus/Sprites/Sad.png")
var happiness: int = -1


func _ready():
	var child_texture = load("res://Santa Claus/Sprites/Child" +  String(get_index()+1) + ".png")
	$ChildSprite.texture = child_texture
	$AnimationPlayer.play("Idle")
	happiness = Certificates.happiness_values[get_index()]
	print(happiness, ", ", Certificates.threshold)
	if happiness < Certificates.threshold:
		$HappinessSprite.texture = sad_sprite
	$GiftSprite.texture = Certificates.gift_textures[get_index()]


func interact():
	if $GiftSprite.texture != null:
		$AnimationPlayer.play("Give Gift")
	else:
		$AnimationPlayer.play("Give Nothing")
	$InteractableArea.disable()
	checked = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name in ["Give Gift", "Give Nothing"]:
		$InteractableArea.player.toggleHold()
		$AnimationPlayer.play("Idle")
