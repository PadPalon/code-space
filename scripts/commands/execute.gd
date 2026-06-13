class_name Execute extends Command

static func build(_arguments: Array[String]):
	return Execute.new()

func get_text():
	return "EXECUTE"

func run_final():
	pass
