extends Label

var previous_command_text = ""


func _ready() -> void:
	Events.connect("command_entered", _on_command_entered)
	Events.connect("console_message_sent", _on_message_sent)


func _on_command_entered(commands: Array[Command]):
	text = previous_command_text
	for command in commands:
		if (command.is_final()):
			text = ""
		else:
			if text.is_empty():
				text = command.get_text()
			else:
				text = text + "\n" + command.get_text()
	previous_command_text = text


func _on_message_sent(message: String):
	text = previous_command_text
	if text.is_empty():
		text = message
	else:
		text = text + "\n" + message
