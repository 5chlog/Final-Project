extends KinematicBody2D

const UP_DIRECTION := Vector2.UP
export var speed := 600.0

export var jump_strength := 1500.0
export var maximum_jumps := 2
export var double_jump_strength := 1200.0
export var gravity := 4500.0

var jumps_made := 0
var velocity := Vector2.ZERO

onready var animation := $AnimationPlayer

func _physics_process(delta: float) -> void:
	var horizontal_direction = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	
	velocity.x = horizontal_direction * speed
	velocity.y += gravity * delta
	
	var is_falling := velocity.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("ui_jump") and is_on_floor()
	var is_double_jumping := Input.is_action_just_pressed("ui_jump") and is_falling
	var is_jump_cancelled := Input.is_action_just_released("ui_jump") and velocity.y < 0.0
	var is_idling := is_on_floor() and is_zero_approx(velocity.x)
	var is_running := is_on_floor() and not is_zero_approx(velocity.x)
	
	if is_jumping:
		jumps_made += 1
		velocity.y = -jump_strength
	elif is_double_jumping:
		jumps_made += 1
		if jumps_made <= maximum_jumps:
			velocity.y = -double_jump_strength
	elif is_jump_cancelled:
		velocity.y = 0.0
	elif is_idling:
		jumps_made = 0
		animation.play("Idle")
	elif is_running:
		jumps_made = 0
		
	if velocity.x > 0.0:
		$Sprite.scale.x = 1
	elif velocity.x < 0.0:
		$Sprite.scale.x = -1
		
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.in_range_items.size() > 0:
			var pickup_item = $PickupZone.in_range_items.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.in_range_items.erase(pickup_item)
	
func _ready():
	pass # Replace with function body.







