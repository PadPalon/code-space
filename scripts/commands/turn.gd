class_name Turn extends Command

var direction
var distance

var target_rotation
var speed

var LEFT = "left"
var left_alias = ["l", "left"]
var RIGHT = "right"
var right_alias = ["r", "right"]
var NONE = "none"

func _init(arguments: Array):
	var direction_argument = arguments[0].to_lower()
	if direction_argument in left_alias:
		direction = LEFT
	elif direction_argument in right_alias:
		direction = RIGHT
	else:
		direction = NONE

	if arguments.size() == 2:
		distance = int(arguments[1]) % 360

func get_text():
	return "TURN " + direction + " " + str(get_distance())

func start(ship: RigidBody2D, delta: float):
	target_rotation = RotationUtils.to_360(ship.global_rotation_degrees)
	if direction == LEFT:
		target_rotation = posmod(target_rotation - get_distance(), 360)
		speed = -1
	elif direction == RIGHT:
		target_rotation = posmod(target_rotation + get_distance(), 360)
		speed = 1
	else:
		speed = 0
	
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

func get_distance():
	return distance if distance else 45
