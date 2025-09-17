extends Sprite2D

class_name Arrow

func update_rotation(direction: Vector2) -> void:
	match direction:
		Vector2.RIGHT:
			rotation = 0
		Vector2.UP:
			rotation = deg_to_rad(-90)
		Vector2.LEFT:
			rotation =  deg_to_rad(-180)
		Vector2.DOWN:
			rotation = deg_to_rad(90)
