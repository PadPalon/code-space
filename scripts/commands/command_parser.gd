class_name CommandParser

static func parse(to_parse: String):
	var parts = to_parse.split(" ")
	var command = parts[0].to_lower()
	var arguments = parts.slice(1)
	match command.to_lower():
		"turn":
			return Turn.new(arguments)
		"thrust":
			return Thrust.new(arguments)
		"reverse":
			return Reverse.new()
		"rotate":
			return Rotate.new(arguments)
		"execute":
			return Execute.new()
		_:
			return null
