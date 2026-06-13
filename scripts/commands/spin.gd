class_name Spin
extends Command

var direction
var target_burn = 1

var target_rotation
var speed

var burn_time = 0

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
				return Spin.new(direction_argument)
			if arguments.size() >= 2 and arguments[1].is_valid_int():
				return Spin.new(direction_argument, int(arguments[1]))
			ConsoleHelper.send_message("Unknown spin duration " + arguments[1])
		else:
			ConsoleHelper.send_message("Unknown spin direction " + arguments[0])
	else:
		ConsoleHelper.send_message("No spin direction")
	return []


static func get_direction(direction_argument: String):
	direction_argument = direction_argument.to_lower()
	if direction_argument in left_alias:
		return left_direction
	if direction_argument in right_alias:
		return right_direction
	return null


func _init(direction_argument: String, burn_argument: int = 1):
	direction = direction_argument
	target_burn = burn_argument


func get_text():
	return "SPIN " + direction + " FOR " + str(int(target_burn - burn_time)) + " SECONDS"


func start(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	if direction == left_direction:
		speed = left_speed
	elif direction == right_direction:
		speed = right_speed

	ship.lock_rotation = false


func run(ship: RigidBody2D, delta: float, stats: ShipStats):
	var torque = speed * stats.rotation_speed
	ship.apply_torque(torque)
	burn_time += delta


func is_finished(_ship: RigidBody2D, _delta: float, _stats: ShipStats):
	var burn_finished = burn_time >= target_burn
	return burn_finished
