extends KinematicBody2D

# WSAD
var velocity = Vector2()
var facingDir = Vector2()
var rayCastdir = Vector2()

# Click and move
var moveTarget = Vector2()
var dir

var moveSpeed = 100

onready var rayCast = $RayCast2D
var interactDist = 500

func _ready():
	moveTarget = self.position

func collision_screening():
	rayCast.cast_to = rayCastdir * interactDist
	var detected_obj = rayCast.get_collider()
	if rayCast.is_colliding():
		if detected_obj.has_method("conversation"):
			detected_obj.show_cloud()
		if detected_obj.has_method("digging"):
			detected_obj.show_mark()

func try_interact():
	var target = rayCast.get_collider()
	if rayCast.is_colliding():

		if target.has_method("conversation"):
			var actions = InputMap.get_actions()
			for action in actions:
				if Input.is_action_pressed(action):
					Input.action_release(action)
			target.conversation()
		
		if target.has_method("digging"):
			target.digging()

func play_animation(anim_name):
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)

func manage_animations_wsad():
	if velocity.x > 0:
		play_animation("MoveRight")
	elif velocity.x < 0:
		play_animation("MoveLeft")
	elif velocity.y < 0:
		play_animation("MoveUp")
	elif velocity.y > 0:
		play_animation("MoveDown")
	elif facingDir.x == 1:
		play_animation("IdleRight")
	elif facingDir.x == -1:
		play_animation("IdleLeft")
	elif facingDir.y == 1:
		play_animation("IdleDown")
	elif facingDir.y == -1:
		play_animation("IdleUp")

func manage_animations_mouse_move():
	if dir.x > 0.5:
		play_animation("MoveRight")
	elif dir.x < -0.5:
		play_animation("MoveLeft")
	elif dir.y < 0.5:
		play_animation("MoveUp")
	elif dir.y > -0.5:
		play_animation("MoveDown")

func manage_animations_mouse_idle():
	if dir.x > 0.5:
		play_animation("IdleRight")
	elif dir.x < -0.5:
		play_animation("IdleLeft")
	elif dir.y > 0.5:
		play_animation("IdleDown")
	elif dir.y < -0.5:
		play_animation("IdleUp")
	

func get_wsad_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
		rayCastdir.y += -1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		rayCastdir.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		rayCastdir.x += -1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		rayCastdir.x += 1
		facingDir = Vector2(1, 0)
	
	velocity = velocity.normalized()
	rayCastdir = rayCastdir.normalized()

func get_mouse_input():
	if Input.is_action_pressed("click"):
		moveTarget = get_global_mouse_position()


func _physics_process(_delta):
	velocity = Vector2()
	# if input is wsad -> get_wsad_input
	# get_wsad_input()
	# velocity = move_and_slide(velocity * moveSpeed)
	# manage_animations_wsad()

	# if input is mouse/touch
	get_mouse_input()
	dir = position.direction_to(moveTarget)
	if position.distance_to(moveTarget) > 5:
		rayCastdir = dir
		velocity = dir * moveSpeed
		velocity = move_and_slide(velocity)
		manage_animations_mouse_move()

		if velocity.x == 0 or velocity.y == 0:
			rayCastdir = dir
			moveTarget = self.position
			manage_animations_mouse_idle()
	else:
		manage_animations_mouse_idle()
	
	# voor beide inputs
	collision_screening()

func _process(_delta):
	if Input.is_action_just_pressed("npc_interact"):
		try_interact()
