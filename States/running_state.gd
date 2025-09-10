extends State

class_name RunningState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("running")

		
func _physics_process(_delta: float) -> void:
	var direction: int = Input.get_axis("move_left", "move_right")
	set_sprite_direction(direction)
	if direction:
		player.direction = direction
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		if player.velocity.x == 0:
			change_state.call("idle")
		


func set_sprite_direction(input_axis: int) -> void:
	if input_axis == 1:
		animated_sprite.flip_h = false
	elif input_axis == -1:
		animated_sprite.flip_h = true
