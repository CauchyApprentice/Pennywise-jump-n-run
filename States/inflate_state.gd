extends State

class_name InflateState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("shoot"):
		release()

func release() -> void:
	
	
	change_state.call("idle")
