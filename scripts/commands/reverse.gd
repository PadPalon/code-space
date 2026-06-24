class_name Reverse
extends Command

var previous_rotation
var target_rotation
var rotation_done = 0


static func get_help():
	return (
			"reverses 180 degrees\n"
			+ "[left | right], direction to turn, defaults to left"
	)


static func build(arguments: Array[String]):
	if arguments.is_empty():
		return Turn.new("left", 180)
	arguments.append("180")
	return Turn.build(arguments)
