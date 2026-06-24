class_name Execute
extends Command

static func build(_arguments: Array[String]):
	return Execute.new()


static func get_help():
	return "starts executing any pending commands"


func get_text():
	return "EXECUTE"


func run_final(pending_commands: Array[Command], executing_commands: Array[Command]):
	executing_commands.clear()
	executing_commands.append_array(pending_commands)
	pending_commands.clear()
	return true
