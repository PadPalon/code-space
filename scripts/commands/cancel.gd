class_name Cancel
extends Command

static func build(_arguments: Array[String]):
	return Cancel.new()


static func get_help():
	return "removes any pending commands"


func get_text():
	return "CANCEL"


func run_final(pending_commands: Array[Command], _executing_commands: Array[Command]) -> bool:
	pending_commands.clear()
	return false
