extends LineEdit

signal command_entered(command: Command)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			var parsed = CommandParser.parse(text)
			if parsed:
				command_entered.emit(parsed)
			text = ""
