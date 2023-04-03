extends KinematicBody2D

export var acceleration = 460
export var max_speed =  225
var velocity = Vector2.ZERO
var item_name
var player = null
var being_picked = false

func _ready():
	item_name = "Slime Potion"
	
func _physics_process(delta):
	if being_picked == false:
		velocity = velocity.move_toward(Vector2(0, max_speed), acceleration * delta)
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, 1)
			queue_free()
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
func pick_up_item(body):
	player = body
	being_picked = true



