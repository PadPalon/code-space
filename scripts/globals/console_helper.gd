class_name ConsoleHelper

static func send_message(message: String):
	Events.emit_signal("console_message_sent", message)
