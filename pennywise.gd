extends CharacterBody2D


const SPEED = 600
const JUMP_VELOCITY = -800.0
var balloon_scene = preload("res://balloon.tscn")
var balloon_cooldown: float = 1

var state: State
var state_factory: StateFactory




func _ready():
	state_factory = StateFactory.new()
	change_state("idle")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and $balloon_timer.is_stopped():
		shoot_balloon()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(Callable(self, "change_state"), $animatedSprite, self)
	add_child(state)
	state.name = "current_state" #for clarity purposes in the editor
		
func shoot_balloon():
	var ball: RigidBody2D = balloon_scene.instantiate()
	get_parent().add_child(ball)
	ball.position = position
	ball.linear_velocity = Vector2(1000, 0)
	$balloon_timer.wait_time = balloon_cooldown
	$balloon_timer.start()
	
	#var direction: int = Input.get_axis("move_left", "move_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
