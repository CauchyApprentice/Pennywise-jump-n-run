extends State

class_name IdleState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("idle")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		if Input.is_action_pressed("down"):
			change_state.call("inflate")
		elif player.get_node("balloon_timer").is_stopped():
			player.shoot_balloon()
			

func _physics_process(delta: float) -> void:
	if Input.get_axis("left", "right"):
		change_state.call("running")
		
	
	
