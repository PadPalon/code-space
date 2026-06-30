class_name Turn
extends Command

var direction
var distance

var speed
var rotation_to_do = 0
var rotation_done = 0

static var left_direction = "left"
static var right_direction = "right"
static var left_alias = ["l", left_direction]
static var right_alias = ["r", right_direction]

static var left_speed = -1
static var right_speed = 1


static func build(arguments: Array[String]):
	if (arguments.size() >= 1):
		var direction_argument = get_direction(arguments[0])
		if direction_argument:
			if arguments.size() == 1:
				return Turn.new(direction_argument)
			if arguments.size() >= 2 and arguments[1].is_valid_int():
				return Turn.new(direction_argument, int(arguments[1]))
			ConsoleHelper.send_message("Unknown turn distance " + arguments[1])
		ConsoleHelper.send_message("Unknown turn direction " + arguments[0])
	ConsoleHelper.send_message("No turn direction")
	return []


static func get_help():
	return (
			"turns some degrees in a direction\n"
			+ "does not slow down at the end of the thrust\n"
			+ "[left | l | right | r], direction to turn\n"
			+ "[<number>], degrees to turn, defaults to 90"
	)


static func get_direction(direction_argument: String):
	direction_argument = direction_argument.to_lower()
	if direction_argument in left_alias:
		return left_direction
	if direction_argument in right_alias:
		return right_direction
	return null


func _init(direction_argument: String, distance_argument: int = 0):
	direction = direction_argument
	distance = distance_argument


func get_text():
	return "TURN " + direction + " " + str(get_distance())


func start(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	rotation_to_do = get_distance()
	if direction == left_direction:
		speed = left_speed
	elif direction == right_direction:
		speed = right_speed

	ship.lock_rotation = false


func run(ship: RigidBody2D, _delta: float, stats: ShipStats):
	var torque
	if rotation_done > rotation_to_do * 0.6:
		torque = speed * stats.rotation_speed * -1
	else:
		torque = speed * stats.rotation_speed
	ship.apply_torque(torque)


func is_finished(ship: RigidBody2D, delta: float, _stats: ShipStats):
	var difference = absf(ship.angular_velocity * delta * (180 / PI))
	rotation_done = rotation_done + difference

	var rotation_reached = rotation_to_do <= rotation_done and absf(ship.angular_velocity) <= 1
	if rotation_reached:
		ship.lock_rotation = true
	return rotation_reached


func get_distance():
	return distance if distance else 90
