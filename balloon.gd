extends RigidBody2D

class_name Balloon

signal bullet_hit(bullet: Node2D)
var gravity: float = 10

var life_time: float = 20 #6
var impulse_list: Array[Vector2] = [Vector2.UP, Vector2.DOWN, Vector2.LEFT]
var impulse_cooldown: float = 1.5
var impulse_strength: float = 300
var impulses: bool = false #do not set this to true by itself, use function start_impulses()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lifeTimer.start(life_time)
	$lifeTimer.paused = true


func _process(_delta: float) -> void:
	if $lifeTimer.is_stopped():
		queue_free()


func _physics_process(delta: float) -> void:
	if not $lifeTimer.paused:
		if not (impulses and impulse_list.size()):
			apply_central_force(Vector2.UP * gravity * mass) #gravity
		if rotation:
			apply_torque(-rotation * 200 * pow(mass, 2))
		
	if impulses and impulse_list.size():	
		get_impulses()


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


func start_life_timer() -> void:
	$lifeTimer.wait_time = life_time
	$lifeTimer.paused = false
	$lifeTimer.start(life_time)


func start_impulses():
	impulses = true
	$impulseTimer.start(impulse_cooldown)


func get_impulses() -> void:
	if not $impulseTimer.is_stopped():
		apply_central_force(impulse_list.front() * impulse_strength * mass)
	else:
		impulse_list.pop_front()
		$impulseTimer.start(impulse_cooldown)
