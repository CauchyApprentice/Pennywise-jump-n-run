extends AnimatedSprite2D

var init_xpos = -9.5
var right_xpos: float = 9.4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if frame == 3: #sprite_index of right look
		position.x = right_xpos
	else:
		position.x = init_xpos
