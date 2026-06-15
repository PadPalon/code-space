class_name StopShip
extends Command

static func build(_arguments: Array[String]):
	return [StopSpin.new(), Rotate.new("retro"), Speed.new(0)] as Array[Command]
