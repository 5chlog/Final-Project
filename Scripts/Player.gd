extends KinematicBody2D
class_name Player

const GRAVITY = Vector2(0, 10)
const TERM_VEL = -500 # Terminal Fall Velocity
const LADDER_CLIMBOVER_OFFSET = 26

enum State {WALK, CLIMB, HOLD}

var velocity: Vector2 = Vector2.ZERO
var input: Vector2 = Vector2.ZERO
var state = State.WALK
var oldstate = State.WALK
var readyingclimb: bool = false
var stoppingclimb: bool = false
var ladderpos: Vector2 = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite
onready var ladderClimbUp = $LadderRays/LadderClimbUp
onready var ladderClimbDown = $LadderRays/LadderClimbDown
onready var ladderJumpDown = $LadderRays/LadderJumpDown
onready var wallBehind = $LadderRays/WallBehind

export(Resource) var playerConstants = load("res://Player Constants/WalkConstants.tres")
export(bool) var holdSignal = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# print(get_children())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if holdSignal:
		toggleHold()
		holdSignal = false
	
	set_input()
	
	match state:
		State.WALK:
			walk()
		State.CLIMB:
			climb()
		State.HOLD:
			return
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func toggleHold():
	if state != State.HOLD:
		oldstate = state
		state = State.HOLD
	else:
		state = oldstate
	
func set_input():
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func walk():
	if is_climbing():
		state = State.CLIMB
		readyingclimb = true
		print(ladderpos, position)
		collision_layer = 4
		collision_mask = 4
		climb()
		return
	face_sprite()
	add_gravity()
	set_walk_velocity()

func climb():
	if readyingclimb:
		velocity = position.direction_to(ladderpos) * playerConstants.MAX_CLIMB_VEL
		if position.distance_to(ladderpos) > 2:
			velocity = move_and_slide(velocity, Vector2.UP)
		else:
			readyingclimb = false
			ladderJumpDown.enabled = true
			wallBehind.enabled = true
		return
	
	if stoppingclimb:
		velocity = position.direction_to(ladderpos) * playerConstants.MAX_CLIMB_VEL
		if position.distance_to(ladderpos) > 2:
			velocity = move_and_slide(velocity, Vector2.UP)
		else:
			stoppingclimb = false
			climb_to_walk()
			velocity.y = 0
		return
	
	velocity.x = 0
	if(input.y == 0):
		velocity.y = move_toward(velocity.y, 0, playerConstants.CLIMB_FRICTION)
	elif(input.y > 0):
		velocity.y = move_toward(velocity.y, playerConstants.MAX_CLIMB_VEL, playerConstants.CLIMB_ACCEL)
	else:
		velocity.y = move_toward(velocity.y, -playerConstants.MAX_CLIMB_VEL, playerConstants.CLIMB_ACCEL)
		
	if is_climbing_off():
		climb_to_walk()
	
func is_climbing():
	if input.y > 0.8 and is_on_floor() and ladderClimbDown.is_colliding() and ladderClimbDown.get_collider() is Ladder:
		var ladder_piece = ladderClimbDown.get_collider()
		ladderpos = ladder_piece.position + ladder_piece.get_parent().position
		return true
	if input.y < -0.8 and ladderClimbUp.is_colliding() and ladderClimbUp.get_collider() is Ladder:
		var ladder_piece = ladderClimbUp.get_collider()
		ladderpos = ladder_piece.position + ladder_piece.get_parent().position
		return true
	return false
	
func is_climbing_off():
	var temp1 = false
	var temp2 = false
	if Input.is_action_just_pressed("ui_jump"):
		temp1 = ladderJumpDown.is_colliding() and not wallBehind.is_colliding()
	# print(is_on_floor())
	if not ladderClimbUp.is_colliding():
		stoppingclimb = true
		ladderpos.y -= LADDER_CLIMBOVER_OFFSET
		print(ladderpos, position)
	elif ladderClimbUp.get_collider() is Ladder:
		var ladder_piece = ladderClimbUp.get_collider()
		ladderpos =  ladder_piece.position + ladder_piece.get_parent().position
	return temp1 or temp2 or (is_on_floor() and input.y > 0)
	
func climb_to_walk():
	state = State.WALK
	Input.action_release("ui_up")
	Input.action_release("ui_down")
	ladderJumpDown.enabled = false
	wallBehind.enabled = false
	collision_layer = 2
	collision_mask = 1
	
func face_sprite():
	if input.x < 0:
		animatedSprite.scale.x = -1
	elif input.x > 0:
		animatedSprite.scale.x = 1
	
func add_gravity():
	velocity += GRAVITY
	if velocity.y < TERM_VEL:
		velocity.y = TERM_VEL
	
func set_walk_velocity():
	if(input.x == 0):
		velocity.x = move_toward(velocity.x, 0, playerConstants.FRICTION)
	elif(input.x > 0):
		velocity.x = move_toward(velocity.x, playerConstants.MAX_HVEL, playerConstants.HACCEL)
	else:
		velocity.x = move_toward(velocity.x, -playerConstants.MAX_HVEL, playerConstants.HACCEL)
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			velocity.y = playerConstants.MAX_JUMP_VEL
	else:
		if(Input.is_action_just_released("ui_jump") and velocity.y < playerConstants.MIN_JUMP_VEL):
			velocity.y = playerConstants.MIN_JUMP_VEL
