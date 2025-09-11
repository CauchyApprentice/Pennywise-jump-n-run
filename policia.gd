extends CharacterBody2D


var range: float = 1000
var bullet_scene := preload("res://Scenes/bullet.tscn")
var bullet_cooldown: float = 0.7
var bullet_offset: Vector2 = Vector2(-70, 0)


func _ready() -> void:
	$raycast_lineOfSight.target_position.x = -range


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_raycast_line_of_sight_target_detected() -> void:
	if $bullet_timer.is_stopped():
		shoot()


func shoot():
	var new_bullet: CharacterBody2D = bullet_scene.instantiate()
	get_parent().add_child(new_bullet)
	new_bullet.position = position
	new_bullet.position += bullet_offset
	new_bullet.velocity = Vector2(-10, 0)
	$bullet_timer.wait_time = bullet_cooldown
	$bullet_timer.start()
