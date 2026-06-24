class_name Abort
extends Command

static func build(_arguments: Array[String]):
	return Abort.new()


static func get_help():
	return "stops any running commands"


func get_text():
	return "ABORT"


func run_final(pending_commands: Array[Command], executing_commands: Array[Command]) -> bool:
	executing_commands.clear()
	pending_commands.remove_at(pending_commands.size() - 1)
	ConsoleHelper.send_message("Aborted")
	return true
