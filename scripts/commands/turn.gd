class_name Turn extends Command

var direction
var distance

var previous_rotation
var target_rotation
var speed
var rotation_to_do = 0
var rotation_done = 0

static var LEFT = "left"
static var RIGHT = "right"
static var left_alias = ["l", LEFT]
static var right_alias = ["r", RIGHT]

static var LEFT_SPEED = -1
static var RIGHT_SPEED = 1

static func build(arguments: Array[String]):
	if (arguments.size() >= 1):
		var direction_argument = get_direction(arguments[0])
		if direction_argument:
			if arguments.size() == 1:
				return Turn.new(direction_argument)
			if arguments.size() >= 2 and arguments[1].is_valid_int():
				return Turn.new(direction_argument, int(arguments[1]))
			else:
				ConsoleHelper.send_message("Unknown turn distance " + arguments[1])
		else:
			ConsoleHelper.send_message("Unknown turn direction " + arguments[0])
	else:
		ConsoleHelper.send_message("No turn direction")
	return []

static func get_direction(direction_argument: String):
	direction_argument = direction_argument.to_lower()
	if direction_argument in left_alias:
		return LEFT
	elif direction_argument in right_alias:
		return RIGHT
	return null

func _init(direction_argument: String, distance_argument: int = 0):
	direction = direction_argument
	distance = distance_argument

func get_text():
	return "TURN " + direction + " " + str(get_distance())

func start(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	previous_rotation = RotationUtils.to_360(ship.global_rotation_degrees)
	rotation_to_do = get_distance()
	if direction == LEFT:
		target_rotation = posmod(previous_rotation - rotation_to_do, 360)
		speed = LEFT_SPEED
	elif direction == RIGHT:
		target_rotation = posmod(previous_rotation + rotation_to_do, 360)
		speed = RIGHT_SPEED

	ship.lock_rotation = false

func run(ship: RigidBody2D, _delta: float, stats: ShipStats):
	var torque
	if rotation_done > rotation_to_do * 0.5 + 1:
		torque = speed * stats.rotation_speed * -1
	else:
		torque = speed * stats.rotation_speed
	ship.apply_torque(torque)

func is_finished(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	var current_rotation = ship.global_rotation_degrees

	var difference = maxf(current_rotation, previous_rotation) - minf(current_rotation, previous_rotation)
	previous_rotation = current_rotation
	if difference > 180:
		difference = absf(difference - 360)
	rotation_done = rotation_done + difference

	var rotation_reached = rotation_to_do <= rotation_done and absf(ship.angular_velocity) <= 1
	if rotation_reached:
		ship.lock_rotation = true
	return rotation_reached

func get_distance():
	return distance if distance else 45
