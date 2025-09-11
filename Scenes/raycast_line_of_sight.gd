extends RayCast2D

signal target_detected

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("player") or collider.is_in_group("balloon"):
			target_detected.emit()
