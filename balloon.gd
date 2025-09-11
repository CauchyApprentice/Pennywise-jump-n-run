extends RigidBody2D

signal bullet_hit(bullet: Node2D)
var life_time: float = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lifeTimer.wait_time = life_time
	$lifeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $lifeTimer.is_stopped():
		queue_free()

func _physics_process(delta: float) -> void:
	apply_central_force(Vector2.UP * 1050)
	if rotation:
		apply_torque(-rotation * 200)


func _on_bullet_hit(bullet: Node2D) -> void:
	bullet.queue_free()
	queue_free()
