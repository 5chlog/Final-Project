extends KinematicBody2D
class_name Player

const GRAVITY = Vector2(0, 10)
const TERM_VEL = -500 # Terminal Fall Velocity
const LADDER_CLIMBOVER_OFFSET = 26 # Offset to adjust difference between ladder and player centers

enum State {IDLE, WALK, RUN, JUMP, FALL, CLIMB, HOLD}


export(Resource) var walk_constants = preload("res://Player/Player Constants/WalkConstants.tres")
export(Resource) var run_constants = preload("res://Player/Player Constants/RunConstants.tres")

var velocity: Vector2 = Vector2.ZERO
var move_input: Vector2 = Vector2.ZERO
var run_flag: bool = false
var jump_pressed: bool = false
var jump_released: bool = false
var state = State.IDLE
var old_state = State.IDLE
var player_constants = walk_constants
var hold_signal = false

var readyingclimb: bool = false
var stoppingclimb: bool = false
var ladderpos: Vector2 = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite
onready var ladderClimbUp = $LadderRays/LadderClimbUp
onready var ladderClimbDown = $LadderRays/LadderClimbDown
onready var ladderJumpDown = $LadderRays/LadderJumpDown
onready var wallBehind = $LadderRays/WallBehind


func _ready():
	velocity = move_and_slide(velocity, Vector2.UP)
	pass


func _physics_process(delta):
	if hold_signal:
		hold_signal = false
		if state != State.HOLD:
			to_hold()
		else:
			if is_on_floor():
				to_idle()
			else:
				to_fall()
			return
	
	match state:
		State.IDLE:
			idle()
		State.WALK:
			walk()
		State.RUN:
			run()
		State.FALL:
			fall()
		State.JUMP:
			jump()
		State.CLIMB:
			climb()
		State.HOLD:
			hold()


func _input(event):
	move_input.x = Input.get_action_strength("game_right") - Input.get_action_strength("game_left")
	move_input.y = Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
	
	if Input.is_action_pressed("game_run"):
		run_flag = true
		player_constants = run_constants
	else:
		run_flag = false
		player_constants = walk_constants
	
	if Input.is_action_just_pressed("game_jump"):
		jump_pressed = true
	else:
		jump_pressed = false
	
	if Input.is_action_just_released("game_jump"):
		jump_released = true
	else:
		jump_released = false
	
	get_viewport().set_input_as_handled()


func toggleHold():
	hold_signal = true


func idle():
	if is_climbing():
		to_climb()
		return
	elif not is_on_floor():
		to_fall()
		return
	elif jump_pressed:
		to_jump()
		return
	elif move_input.x != 0:
		if run_flag:
			to_run()
		else:
			to_walk()
		return
	
	add_gravity()
	velocity.x = move_toward(velocity.x, 0, player_constants.FRICTION)
	
	move_and_slide(velocity, Vector2.UP)

func walk():
	if is_climbing():
		to_climb()
		return
	elif not is_on_floor():
		to_fall()
		return
	elif jump_pressed:
		to_jump()
		return
	elif move_input.x == 0:
		to_idle()
		return
	elif run_flag:
		to_run()
		return
	
	face_sprite()
	add_gravity()
	set_horizontal_velocity()
	
	velocity = move_and_slide(velocity, Vector2.UP)


func run():
	if is_climbing():
		to_climb()
		return
	elif not is_on_floor():
		to_fall()
		return
	elif jump_pressed:
		to_jump()
		return
	elif move_input.x == 0:
		to_idle()
		return
	elif not run_flag:
		to_walk()
		return
	
	face_sprite()
	add_gravity()
	set_horizontal_velocity()
	
	velocity = move_and_slide(velocity, Vector2.UP)


func fall():
	if is_climbing():
		to_climb()
		return
	elif is_on_floor():
		if move_input.x == 0:
			to_idle()
		elif run_flag:
			to_run()
		else:
			to_walk()
		return
	
	face_sprite()
	add_gravity()
	set_horizontal_velocity()
	
	velocity = move_and_slide(velocity, Vector2.UP)


func jump():
	if is_climbing():
		to_climb()
		return
	elif velocity.y >= 0:
		to_fall()
		return
	
	face_sprite()
	add_gravity()
	set_horizontal_velocity()
	
	if(jump_released and velocity.y < player_constants.MIN_JUMP_VEL):
			velocity.y = player_constants.MIN_JUMP_VEL
	
	velocity = move_and_slide(velocity, Vector2.UP)


func climb():
	# When climbing onto the ladder
	if readyingclimb:
		velocity = position.direction_to(ladderpos) * player_constants.MAX_CLIMB_VEL
		if position.distance_to(ladderpos) > 2:
			velocity = move_and_slide(velocity, Vector2.UP)
		else:
			readyingclimb = false
			velocity.x = 0
			ladderJumpDown.enabled = true
			wallBehind.enabled = true
		return
	
	# When climbing off the top of the ladder
	if stoppingclimb:
		velocity = position.direction_to(ladderpos) * player_constants.MAX_CLIMB_VEL
		if position.distance_to(ladderpos) > 2:
			velocity = move_and_slide(velocity, Vector2.UP)
		else:
			stoppingclimb = false
			to_idle()
			velocity.y = 0
		return
	
	if is_climbing_off():
		to_fall()
		return
	
	set_climb_velocity()
	
	velocity = move_and_slide(velocity, Vector2.UP)


func hold():
	add_gravity()
	velocity = move_and_slide(velocity, Vector2.UP)


func is_climbing():
	if move_input.y > 0.8 and is_on_floor() and ladderClimbDown.is_colliding() and ladderClimbDown.get_collider() is Ladder:
		var ladder_piece = ladderClimbDown.get_collider()
		ladderpos = ladder_piece.position + ladder_piece.get_parent().position
		return true
	if move_input.y < -0.8 and ladderClimbUp.is_colliding() and ladderClimbUp.get_collider() is Ladder:
		var ladder_piece = ladderClimbUp.get_collider()
		ladderpos = ladder_piece.position + ladder_piece.get_parent().position
		return true
	return false


func is_climbing_off():
	var temp1 = false
	var temp2 = false
	if Input.is_action_just_pressed("ui_jump"):
		temp1 = ladderJumpDown.is_colliding() and not wallBehind.is_colliding()
	if not ladderClimbUp.is_colliding():
		stoppingclimb = true
		ladderpos.y -= LADDER_CLIMBOVER_OFFSET
		print(ladderpos, position)
	elif ladderClimbUp.get_collider() is Ladder:
		var ladder_piece = ladderClimbUp.get_collider()
		ladderpos =  ladder_piece.position + ladder_piece.get_parent().position
	return temp1 or temp2 or (is_on_floor() and move_input.y > 0)


func to_idle():
	print("To Idle")
	if state == State.CLIMB:
		Input.action_release("ui_up")
		Input.action_release("ui_down")
		ladderJumpDown.enabled = false
		wallBehind.enabled = false
		collision_layer = 2
		collision_mask = 1
	old_state = state
	state = State.IDLE
	idle()


func to_walk():
	print("To Walk")
	if state == State.CLIMB:
		Input.action_release("ui_up")
		Input.action_release("ui_down")
		ladderJumpDown.enabled = false
		wallBehind.enabled = false
		collision_layer = 2
		collision_mask = 1
	
	old_state = state
	state = State.WALK
	walk()


func to_run():
	print("To Run")
	if state == State.CLIMB:
		Input.action_release("ui_up")
		Input.action_release("ui_down")
		ladderJumpDown.enabled = false
		wallBehind.enabled = false
		collision_layer = 2
		collision_mask = 1
	
	old_state = state
	state = State.RUN
	run()


func to_fall():
	print("To Fall")
	if state == State.CLIMB:
		Input.action_release("ui_up")
		Input.action_release("ui_down")
		ladderJumpDown.enabled = false
		wallBehind.enabled = false
		collision_layer = 2
		collision_mask = 1
	old_state = state
	state = State.FALL
	
	fall()


func to_jump():
	print("To Jump")
	old_state = state
	state = State.JUMP
	
	velocity.y = player_constants.MAX_JUMP_VEL
	jump()


func to_climb():
	print("To Climb Idle")
	old_state = state
	state = State.CLIMB
	readyingclimb = true
	print(ladderpos, position)
	collision_layer = 4
	collision_mask = 4
	climb()


func to_hold():
	print("To Hold")
	velocity = Vector2.ZERO
	old_state = state
	state = State.HOLD


func face_sprite():
	if move_input.x < 0:
		animatedSprite.scale.x = -1
	elif move_input.x > 0:
		animatedSprite.scale.x = 1


func add_gravity():
	velocity += GRAVITY
	if velocity.y < TERM_VEL:
		velocity.y = TERM_VEL


func set_horizontal_velocity():
	if(move_input.x == 0):
		velocity.x = move_toward(velocity.x, 0, player_constants.FRICTION)
	elif(move_input.x > 0):
		velocity.x = move_toward(velocity.x, player_constants.MAX_HVEL, player_constants.HACCEL)
	else:
		velocity.x = move_toward(velocity.x, -player_constants.MAX_HVEL, player_constants.HACCEL)


func set_climb_velocity():
	if(move_input.y == 0):
		velocity.y = move_toward(velocity.y, 0, player_constants.CLIMB_FRICTION)
	elif(move_input.y > 0):
		velocity.y = move_toward(velocity.y, player_constants.MAX_CLIMB_VEL, player_constants.CLIMB_ACCEL)
	else:
		velocity.y = move_toward(velocity.y, -player_constants.MAX_CLIMB_VEL, player_constants.CLIMB_ACCEL)
