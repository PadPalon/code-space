class_name Speed
extends Command

var start_speed: float
var start_direction: int
var start_difference: float
var target_speed: float

var direction_flipped: bool = false
var thrust_time: float = 0


static func build(arguments: Array[String]):
	if arguments.size() >= 1 and arguments[0].is_valid_float():
		return Speed.new(float(arguments[0]))
	return null


static func get_help():
	return (
			"tries to reach a given speed by thrusting\n"
			+ "aborts if speed is changing in wrong direction\n"
			+ "[<number>], speed to reach"
	)


func _init(speed: float):
	target_speed = speed


func get_text():
	return "SPEED TO " + str(target_speed)


func start(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	start_speed = ship.linear_velocity.length()
	start_direction = int(ship.linear_velocity.angle())
	start_difference = get_speed_difference(ship)


func run(ship: RigidBody2D, delta: float, stats: ShipStats):
	ship.apply_central_force(Vector2.from_angle(ship.rotation) * stats.thrust)
	thrust_time = thrust_time + delta


func is_finished(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	var current_speed = ship.linear_velocity.length()
	if start_direction != int(ship.linear_velocity.angle()):
		return true
	if start_speed >= target_speed and current_speed <= target_speed:
		return true
	if start_speed < target_speed and current_speed >= target_speed:
		return true
	if thrust_time > 1:
		# abort if speed does not change in correct direction
		if start_speed >= target_speed and get_speed_difference(ship) >= start_difference:
			return true
		if start_speed < target_speed and get_speed_difference(ship) <= start_difference:
			return true

	return false


func get_speed_difference(ship: RigidBody2D):
	var current_speed = ship.linear_velocity.length()
	return abs(target_speed - current_speed)
