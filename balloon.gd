extends RigidBody2D

class_name Balloon

signal bullet_hit(bullet: Node2D)
var life_time: float = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lifeTimer.start()
	$lifeTimer.paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $lifeTimer.is_stopped():
		queue_free()

func _physics_process(delta: float) -> void:
	if $lifeTimer.paused == false:
		apply_central_force(Vector2.UP * 1050)
		if rotation:
			apply_torque(-rotation * 200)


func _on_bullet_hit(bullet: Node2D) -> void:
	bullet.queue_free()
	queue_free()


func increase_size(increment: float) -> void:
	var new_sprite_scale: Vector2 = $Sprite2D.scale + Vector2(increment, increment)
	var quotient: float = new_sprite_scale.x / $Sprite2D.scale.x #can take x or y since its uniform
	$Sprite2D.scale = new_sprite_scale
	
	var collision_shape := $CollisionShape2D.shape as CapsuleShape2D
	collision_shape.height *= quotient
	collision_shape.radius *= quotient
	
	mass *= quotient
	life_time *= quotient
	print(life_time)
	


func start_life_timer() -> void:
	$lifeTimer.wait_time = life_time
	$lifeTimer.paused = false
