class_name Rotate extends Command

var string_direction
var direction
var target_rotation
var speed

var RETROGRADE = "retrograde"
var retrograde_alias = ["retro"]
var PROGRADE = "prograde"
var prograde_alias = ["pro"]

func _init(arguments: Array):
	if arguments[0].is_valid_int():
		target_rotation = RotationUtils.to_360(int(arguments[0]) % 360)
	else:
		string_direction = arguments[0].to_lower()
		if string_direction in retrograde_alias:
			string_direction = RETROGRADE
		if string_direction in prograde_alias:
			string_direction = PROGRADE


func get_text():
	return "ROTATE TO " + (string_direction if string_direction else str(target_rotation))

func start(ship: RigidBody2D, delta: float):
	if string_direction == RETROGRADE:
		target_rotation = RotationUtils.to_360(rad_to_deg(ship.linear_velocity.angle()) + 180)
	elif string_direction == PROGRADE:
		target_rotation = RotationUtils.to_360(rad_to_deg(ship.linear_velocity.angle()))
	print(target_rotation)

	var source_rotation = RotationUtils.to_360(ship.global_rotation_degrees)
	if RotationUtils.distance_left(source_rotation, target_rotation) > RotationUtils.distance_right(source_rotation, target_rotation):
		speed = 1
	else:
		speed = -1
	
	ship.lock_rotation = false

func run(ship: RigidBody2D, delta: float):
	ship.apply_torque(speed * 100)

func is_finished(ship: RigidBody2D, delta: float):
	var current = RotationUtils.to_360(ship.global_rotation_degrees)
	var rotation_reached = current == target_rotation
	if rotation_reached:
		ship.global_rotation_degrees = RotationUtils.to_180(target_rotation)
		ship.lock_rotation = true
	return rotation_reached
