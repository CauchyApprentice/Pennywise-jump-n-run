extends Node2D

var life_time: float = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$lifeTimer.wait_time = life_time
	$lifeTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $lifeTimer.is_stopped():
		queue_free()
