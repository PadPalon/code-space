class_name Thrust extends Command

var target_burn
var burn_time = 0

static func build(arguments: Array[String]):
	if arguments.is_empty():
		return Thrust.new(1)
	if arguments.size() >= 1 and arguments[0].is_valid_int():
		return Thrust.new(int(arguments[0]))
	else:
		ConsoleHelper.send_message("Invalid thrust duration" + arguments[0])
	return []

func _init(duration_argument: int):
	target_burn = duration_argument

func get_text():
	return "THRUST " + str(int(target_burn - burn_time)) + " SECONDS"

func run(ship: RigidBody2D, delta: float, stats: ShipStats):
	ship.apply_central_force(Vector2.from_angle(ship.rotation) * stats.thrust)
	burn_time += delta

func is_finished(_ship: RigidBody2D, _delta: float, _stats: ShipStats):
	var burn_finished = burn_time >= target_burn
	return burn_finished
