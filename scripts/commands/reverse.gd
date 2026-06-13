class_name Reverse
extends Command

var previous_rotation
var target_rotation
var rotation_done = 0


static func build(arguments: Array[String]):
	if arguments.is_empty():
		return Turn.new("left", 180)
	else:
		arguments.append("180")
		return Turn.build(arguments)
