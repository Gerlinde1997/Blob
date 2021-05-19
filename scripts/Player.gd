extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()
var rayCastdir = Vector2()

var moveSpeed = 80

onready var rayCast = $RayCast2D
var interactDist = 600

func try_interact():
	var target = rayCast.get_collider()
	if rayCast.is_colliding():
		if target.has_method("conversation"):
			var actions = InputMap.get_actions()
			for action in actions:
				if Input.is_action_pressed(action):
					Input.action_release(action)
			target.conversation()

func play_animation(anim_name):
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)

func manage_animations():
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


func _physics_process(_delta):
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

	move_and_slide(velocity * moveSpeed)
	manage_animations()
	rayCast.cast_to = rayCastdir * interactDist

func _process(_delta):
	if Input.is_action_just_pressed("npc_interact"):
		try_interact()
