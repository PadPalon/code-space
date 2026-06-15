extends RigidBody2D

var pending_commands: Array[Command] = []
var executing_commands: Array[Command] = []
var executing_command: Command

var stats: ShipStats


func _ready() -> void:
	Events.connect("command_entered", _on_command_entered)
	stats = ShipStats.new(10, 300)


func _on_command_entered(commands: Array[Command]):
	for command in commands:
		if command.is_final():
			var stop_executing: bool = command.run_final(pending_commands, executing_commands)
			if stop_executing:
				executing_command = null
		else:
			pending_commands.append(command)


func _physics_process(delta: float):
	if not executing_command and not executing_commands.is_empty():
		executing_command = executing_commands.pop_front()
		executing_command.start(self, delta, stats)

	if executing_command:
		ConsoleHelper.send_message("Executing: " + executing_command.get_text())
		if executing_command.is_finished(self, delta, stats):
			executing_command = null
			if (executing_commands.is_empty()):
				ConsoleHelper.send_message("Finished executing")
		else:
			executing_command.run(self, delta, stats)
