extends State

class_name InflateState

var balloon_scene = preload("res://Scenes/balloon.tscn")
var inflating_ball: Balloon
var ball_offset: Vector2
var offset_angle: float = 45
var size_inc: float = 0.0001

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball_offset = Vector2(100 * player.direction, 0)
	inflating_ball = balloon_scene.instantiate()
	player.get_parent().add_child(inflating_ball)
	inflating_ball.freeze = true
	inflating_ball.rotate(offset_angle * player.direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instance_valid(inflating_ball):
		change_state.call("idle")
		return
	
	inflating_ball.position = player.position + ball_offset
	inflating_ball.increase_size(size_inc)
	
	if Input.is_action_just_released("shoot"):
		release()

func release() -> void:
	
	
	inflating_ball.start_life_timer()
	inflating_ball.freeze = false
	change_state.call("idle")
