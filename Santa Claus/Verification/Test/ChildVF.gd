extends Node2D

var checked:bool = false
var sad_sprite = preload("res://Santa Claus/Sprites/Sad.png")
var happiness: int = -1
var gifts = null
var counter:int = 0

func _ready():
	var child_texture = load("res://Santa Claus/Sprites/Child" +  String(get_index()+1) + ".png")
	$ChildSprite.texture = child_texture
	$AnimationPlayer.play("Idle")
	happiness = Certificates.happiness_values[get_index()]
	print(happiness, ", ", Certificates.threshold)
	if happiness < Certificates.threshold:
		$HappinessSprite.texture = sad_sprite
	gifts = Certificates.gift_textures[get_index()]


func interact():
	if gifts.size() != 0 :
		if counter < len(gifts) :
			play_gift_animton()
	else:
		$AnimationPlayer.play("Give Nothing")
		
	$InteractableArea.disable()
	checked = true


func play_gift_animton():
	$GiftSprite.texture = gifts[counter]
	$AnimationPlayer.play("Give Gift")


func _on_AnimationPlayer_animation_finished(anim_name):
	if gifts.size() != 0 : 
		counter += 1
		if counter < gifts.size() :
			play_gift_animton()
			return
		elif counter == gifts.size() : 
			$AnimationPlayer.play("Give Nothing")
			return

	if anim_name in ["Give Gift", "Give Nothing"]:
		$InteractableArea.player.toggleHold()
		$AnimationPlayer.play("Idle")
