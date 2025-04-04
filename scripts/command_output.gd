extends Label

func _on_command_entered(command: Command):
	if (command.is_final()):
		text = ""
	else:
		if text.is_empty():
			text = command.get_text()
		else:
			text = text + "\n" + command.get_text()
