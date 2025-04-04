class_name Reverse extends Command

var target_rotation

func get_text():
	return "REVERSE"

func start(ship: RigidBody2D, delta: float):
	target_rotation = RotationUtils.to_360(ship.global_rotation_degrees + 180)
	
	ship.lock_rotation = false

func run(ship: RigidBody2D, delta: float):
	ship.apply_torque(100)

func is_finished(ship: RigidBody2D, delta: float):
	var current = RotationUtils.to_360(ship.global_rotation_degrees)
	var rotation_reached = current == target_rotation
	if rotation_reached:
		ship.global_rotation_degrees = RotationUtils.to_180(target_rotation)
		ship.lock_rotation = true
	return rotation_reached