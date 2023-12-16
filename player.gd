extends CharacterBody2D

@onready var anim:AnimationPlayer = $Anim
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim.play("jump")

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.get_axis("ui_left", "ui_right") == -1:
		$Sprite2D.flip_h = true
	elif Input.get_axis("ui_left", "ui_right") == 1:
		$Sprite2D.flip_h = false
	else: anim.play("idle")
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		anim.play("walk")
		velocity.x = direction * SPEED
	else:
		anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
