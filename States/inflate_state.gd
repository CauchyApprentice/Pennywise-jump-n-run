extends State

class_name InflateState

var balloon_scene = preload("res://Scenes/balloon.tscn")
var arrow_scene = preload("res://Scenes/arrow.tscn")
var inflating_ball: Balloon
var ball_offset: Vector2
var offset_angle: float = deg_to_rad(30)
var size_inc: float = 0.00002
var inflate_time_limit: float = 2
var inflate_time: float = 0
var arrow: Arrow
var show_arrow: bool = false
var ball_impulse_list: Array[Vector2] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball_offset = Vector2(100 * player.direction, 0)
	inflating_ball = balloon_scene.instantiate()
	player.get_parent().add_child(inflating_ball)
	inflating_ball.freeze = true
	inflating_ball.rotate(offset_angle * player.direction)
	
	inflating_ball.position = player.position + ball_offset
	
	arrow = arrow_scene.instantiate()
	arrow.visible = false
	player.get_parent().add_child(arrow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instance_valid(inflating_ball): #balloon was destroyed during inflation
		change_state.call("idle")
		return
	
	inflating_ball.position = player.position + ball_offset
	
	if inflate_time < inflate_time_limit:
		inflating_ball.increase_size(size_inc)
		inflate_time += delta

	
	arrow.position = player.position + Vector2(0,-200)
	
	if show_arrow:
		input_turn_arrow()
	else:
		if input_turn_arrow():
			show_arrow = true
	

		
	
	
	if Input.is_action_just_released("shoot"):
		release()

func release() -> void:
	
	
	inflating_ball.start_life_timer()
	inflating_ball.impulse_list = ball_impulse_list
	inflating_ball.start_impulses()
	inflating_ball.freeze = false
	
	arrow.queue_free()
	
	change_state.call("idle")


func turn_arrow(direction: Vector2) -> void:
	arrow.visible = true
	arrow.update_rotation(direction)
	

func input_turn_arrow() -> bool: #registers inputs and changes arrow direction, also returns if such an input was registered
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_just_pressed("down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("right"):
		direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("left"):
		direction = Vector2.LEFT

	if direction:
		turn_arrow(direction)
		ball_impulse_list.append(direction.normalized())
		return true
		
	return false
