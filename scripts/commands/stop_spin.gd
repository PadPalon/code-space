class_name StopSpin
extends Command

static func build(_arguments: Array[String]):
	return StopSpin.new()


func get_text():
	return "STOP SPIN"


func run(ship: RigidBody2D, _delta: float, stats: ShipStats):
	ship.apply_torque(stats.rotation_speed * signf(ship.angular_velocity) * -1)


func is_finished(ship: RigidBody2D, _delta: float, _stats: ShipStats):
	var rotation_stopped = absf(ship.angular_velocity) <= 1
	if rotation_stopped:
		ship.lock_rotation = true
	return rotation_stopped
