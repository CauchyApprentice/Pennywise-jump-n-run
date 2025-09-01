extends Camera2D

var pennywise: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pennywise = get_parent().get_node("pennywise")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = pennywise.position.x
