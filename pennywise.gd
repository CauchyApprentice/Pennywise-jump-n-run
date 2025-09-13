extends CharacterBody2D


const JUMP_VELOCITY = -600
var balloon_scene = preload("res://Scenes/balloon.tscn")
var balloon_cooldown: float = 0.3
var balloon_offset: Vector2 = Vector2(100, 0)

var state: State
var state_factory: StateFactory

var direction: int = 1 # 1 for pos x, -1 for neg x

signal bullet_hit(bullet: Node2D)




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

	move_and_slide()




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
	ball.position += direction * balloon_offset
	ball.linear_velocity = Vector2(direction * 500, 150)
	ball.linear_velocity += velocity
	$balloon_timer.wait_time = balloon_cooldown
	$balloon_timer.start()


func _on_bullet_hit(bullet: Node2D) -> void:
	bullet.queue_free()
