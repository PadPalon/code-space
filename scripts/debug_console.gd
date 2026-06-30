extends RichTextLabel

@export var ship: RigidBody2D


func _process(_delta: float):
	if ship != null:
		var formatted_message = (
				"Rotation Direction: %d\n"
				+ "Rotation Speed: %d\n"
				+ "Speed: %d"
		) % [
			RotationUtils.to_360(ship.global_rotation_degrees + 90),
			absf(ship.angular_velocity * (180 / PI)),
			ship.linear_velocity.length(),
		]
		text = formatted_message
