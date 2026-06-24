class_name StopShip
extends Command

static func build(_arguments: Array[String]):
	return [StopSpin.new(), Rotate.new("retro"), Speed.new(0)] as Array[Command]


static func get_help():
	return "turns ship to retrograde and thrusts until speed is zero"
