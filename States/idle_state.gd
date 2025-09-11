extends State

class_name IdleState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("idle")


func _physics_process(delta: float) -> void:
	if Input.get_axis("move_left", "move_right"):
		change_state.call("running")
	
