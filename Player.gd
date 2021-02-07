extends KinematicBody2D

var velocity = Vector2()
var facingDir = Vector2()

var moveSpeed = 80

var current_position

onready var rayCast = $RayCast2D
var interactDist = 500

func try_interact():
	rayCast.cast_to = facingDir * interactDist
	var target = rayCast.get_collider()
	if rayCast.is_colliding():
		if target.has_method("conversation"):
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

func _physics_process(delta):
	velocity = Vector2()

	if Input.is_action_pressed("move_up"):
		velocity.y += -1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		facingDir = Vector2(1, 0)
	
	velocity = velocity.normalized()
	
	move_and_slide(velocity * moveSpeed)
	manage_animations()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		try_interact()
