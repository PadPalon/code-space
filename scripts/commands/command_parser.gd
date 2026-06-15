class_name CommandParser

static func parse(to_parse: String) -> Array[Command]:
	var parts = to_parse.split(" ")
	var command = parts[0].to_lower()
	var arguments = parts.slice(1)
	var parsed
	match command.to_lower():
		"turn":
			parsed = Turn.build(arguments)
		"thrust":
			parsed = Thrust.build(arguments)
		"reverse":
			parsed = Reverse.build(arguments)
		"rotate":
			parsed = Rotate.build(arguments)
		"spin":
			parsed = Spin.build(arguments)
		"stop-spin":
			parsed = StopSpin.build(arguments)
		"speed":
			parsed = Speed.build(arguments)
		"break":
			parsed = StopShip.build(arguments)
		"execute":
			parsed = Execute.build(arguments)
		"abort":
			parsed = Abort.build(arguments)
		"cancel":
			parsed = Cancel.build(arguments)
		var unknown_command:
			ConsoleHelper.send_message("Unknown command " + unknown_command)
	if parsed is Array[Command]:
		return parsed
	if parsed is Command:
		return [parsed] as Array[Command]
	return [] as Array[Command]
