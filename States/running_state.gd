extends State

class_name RunningState

var direction_x: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("running")
	if direction_x == -1:
		flip_sprite_h()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player.velocity.x == 0:
		#change_state.call("idle")
		pass
		
func _physics_process(_delta: float) -> void:
	move()
	
func flip_sprite_h() -> void:
	animated_sprite.flip_h = not animated_sprite.flip_h
	
	
func orientate_sprite() -> void:
	if direction_x == 1 and animated_sprite.flip_h:
		flip_sprite_h()
	elif direction_x == -1 and not animated_sprite.flip_h:
		flip_sprite_h()
			
		

func move() -> void:
	if Input.is_action_pressed("move_left"):
		direction_x = -1
	elif Input.is_action_pressed("move_right"):
		direction_x = 1
	
	orientate_sprite()
	player.velocity.x = player.SPEED * direction_x
	player.move_and_slide()
