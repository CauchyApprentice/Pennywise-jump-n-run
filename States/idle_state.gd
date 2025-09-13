extends State

class_name IdleState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("idle")


func _physics_process(delta: float) -> void:
	if Input.get_axis("left", "right"):
		change_state.call("running")
		
	if Input.is_action_just_pressed("shoot") and Input.is_action_pressed("down"):
		change_state.call("inflate")
	
