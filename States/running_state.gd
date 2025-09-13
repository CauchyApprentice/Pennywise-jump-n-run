extends State

class_name RunningState

var runtime: float = 0
var speed_0: float = 300
var speed_1: float = 400
var speed_2: float = 600
var sprint_time_1: float = 1
var sprint_time_2: float = 2.5

var speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("running")

		
func _physics_process(delta: float) -> void:
	sprint_progression(delta)
	
	var direction: int = Input.get_axis("left", "right")
	set_sprite_direction(direction)
	if direction:
		player.direction = direction
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		if player.velocity.x == 0:
			change_state.call("idle")
		


func set_sprite_direction(input_axis: int) -> void:
	if input_axis == 1:
		animated_sprite.flip_h = false
	elif input_axis == -1:
		animated_sprite.flip_h = true
		
func sprint_progression(delta) -> void:
	runtime += delta
	if runtime < sprint_time_1:
		speed = speed_0
	elif runtime < sprint_time_2:
		speed = speed_1
	else:
		speed = speed_2
