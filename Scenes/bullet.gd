extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity)
	if collision:
		var collider := collision.get_collider()
		if collider.is_in_group("terrain"):
			queue_free()
		elif collider.is_in_group("player") or collider.is_in_group("balloon"):
			if collider.is_in_group("balloon"):
				print("i float")
			collider.bullet_hit.emit(self)
