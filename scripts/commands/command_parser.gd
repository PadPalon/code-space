class_name CommandParser

static var command_map := {
	"turn": Turn,
	"thrust": Thrust,
	"reverse": Reverse,
	"rotate": Rotate,
	"spin": Spin,
	"stop-spin": StopSpin,
	"speed": Speed,
	"break": StopShip,
	"execute": Execute,
	"abort": Abort,
	"cancel": Cancel,
	"help": Help,
}


static func parse(to_parse: String) -> Array[Command]:
	var parts = to_parse.split(" ")
	var command = parts[0].to_lower()
	var arguments = parts.slice(1)
	var parsed
	if command_map.has(command):
		parsed = command_map[command].build(arguments)
	else:
		ConsoleHelper.send_message("Unknown command " + command)
	if parsed is Array[Command]:
		return parsed
	if parsed is Command:
		return [parsed] as Array[Command]
	return [] as Array[Command]
