class_name Help
extends Command

static func build(arguments: Array[String]):
	if (arguments.size() >= 1):
		var command_argument = arguments[0]
		if CommandParser.command_map.has(command_argument):
			var help_text = CommandParser.command_map[command_argument].get_help()
			if help_text == null:
				help_text = command_argument
			else:
				help_text = command_argument + "\n" + help_text
			ConsoleHelper.send_message(help_text)
			return []
		ConsoleHelper.send_message("Unknown command " + command_argument)
		return []
	var all_commands = CommandParser.command_map.keys()
	all_commands.sort()
	ConsoleHelper.send_message("\n".join(all_commands))
	return []


static func get_help():
	return (
			"prints help text\n"
			+ "[<command>], prints help text of a command, otherwise prints all commands"
	)
