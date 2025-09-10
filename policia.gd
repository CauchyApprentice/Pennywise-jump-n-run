extends CharacterBody2D


var range: float = 1000


func _ready() -> void:
	$raycast_lineOfSight.target_position.x = -range

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
