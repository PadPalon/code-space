class_name Rotate extends Command

var string_direction
var direction
var previous_rotation
var target_rotation
var speed
var rotation_to_do = 0
var rotation_done = 0

static var RETROGRADE = "retrograde"
static var retrograde_alias = [RETROGRADE, "retro"]
static var PROGRADE = "prograde"
static var prograde_alias = [PROGRADE, "pro"]

static var LEFT_SPEED = -1
static var RIGHT_SPEED = 1

static func build(arguments: Array[String]):
	var commands: Array[Command] = []
	if arguments.size() >= 1:
		var argument = arguments[0]
		if (argument.is_valid_int() or get_string_direction(argument)):
			commands.append(StopSpin.new())
			commands.append(Rotate.new(argument))
		else:
			ConsoleHelper.send_message("Invalid rotation target " + argument)
	else:
		ConsoleHelper.send_message("No rotation target")
	return commands

static func get_string_direction(direction_argument: String):
	direction_argument = direction_argument.to_lower()
	if direction_argument in retrograde_alias:
		return RETROGRADE
	if direction_argument in prograde_alias:
		return PROGRADE
	return null

func _init(direction_argument: String):
	if direction_argument.is_valid_int():
		target_rotation = RotationUtils.to_360(int(direction_argument) - 90 % 360)
	else:
		string_direction = direction_argument.to_lower()
		if string_direction in retrograde_alias:
			string_direction = RETROGRADE
		if string_direction in prograde_alias:
			string_direction = PROGRADE


func get_text():
	return "ROTATE TO " + (string_direction if string_direction else str((target_rotation + 90) % 360))

func start(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	if string_direction == RETROGRADE:
		target_rotation = RotationUtils.to_360(rad_to_deg(ship.linear_velocity.angle()) + 180)
	elif string_direction == PROGRADE:
		target_rotation = RotationUtils.to_360(rad_to_deg(ship.linear_velocity.angle()))

	previous_rotation = RotationUtils.to_360(ship.global_rotation_degrees)
	var distance_left = RotationUtils.distance_left(previous_rotation, target_rotation)
	var distance_right = RotationUtils.distance_right(previous_rotation, target_rotation)
	if distance_left > distance_right:
		speed = RIGHT_SPEED
		rotation_to_do = distance_right
	else:
		speed = LEFT_SPEED
		rotation_to_do = distance_left

	ship.lock_rotation = false

func run(ship: RigidBody2D, _delta: float, stats: ShipStats):
	var torque
	if rotation_done > rotation_to_do * 0.5 + 1:
		torque = speed * stats.rotation_speed * -1
	else:
		torque = speed * stats.rotation_speed

	ship.apply_torque(torque)

func is_finished(ship: RigidBody2D, delta: float, stats: ShipStats):
	var current_rotation = ship.global_rotation_degrees

	var difference = maxf(current_rotation, previous_rotation) - minf(current_rotation, previous_rotation)
	previous_rotation = current_rotation
	if difference > 180:
		difference = absf(difference - 360)
	rotation_done = rotation_done + difference

	var rotation_reached = rotation_to_do <= rotation_done and absf(ship.angular_velocity) <= 1
	if rotation_reached:
		if RotationUtils.to_360(ship.global_rotation_degrees) != target_rotation:
			rotation_done = 0
			rotation_reached = false
			start(ship, delta, stats)
		else:
			ship.global_rotation_degrees = RotationUtils.to_180(target_rotation)
			ship.lock_rotation = true
	return rotation_reached
