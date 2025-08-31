extends CharacterBody2D


const SPEED = 600
const JUMP_VELOCITY = -800.0
var balloon_scene = preload("res://balloon.tscn")

var action_state: ActionState


func shoot_balloon():
	var ball: RigidBody2D = balloon_scene.instantiate()
	get_parent().add_child(ball)
	ball.position = position
	ball.linear_velocity = Vector2(1000, 0)


func _ready():
	action_state = 


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot_balloon()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: int = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
