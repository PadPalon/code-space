class_name Cancel
extends Command

static func build(_arguments: Array[String]):
	return Cancel.new()


func get_text():
	return "CANCEL"


func run_final(_pending_commands: Array[Command], _executing_commands: Array[Command]) -> bool:
	return false
