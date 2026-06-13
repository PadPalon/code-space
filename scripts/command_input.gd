class_name CommandInput
extends LineEdit

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			grab_focus()
			if text != "":
				var parsed: Array[Command] = CommandParser.parse(text)
				if !parsed.is_empty():
					Events.emit_signal("command_entered", parsed)
				text = ""
