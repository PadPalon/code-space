extends RigidBody2D

var pending_commands: Array[Command] = []
var executing_commands: Array[Command] = []
var executing_command: Command

func _on_command_entered(command: Command):
	if command.is_final():
		command.run_final()
		executing_command = null
		executing_commands.clear()
		executing_commands.append_array(pending_commands)
		pending_commands.clear()
	else:
		pending_commands.append(command)

func _physics_process(delta: float):
	if not executing_command and not executing_commands.is_empty():
		executing_command = executing_commands.pop_front()
		executing_command.start(self, delta)
	
	if executing_command:
		if executing_command.is_finished(self, delta):
			executing_command = null
		else:
			executing_command.run(self, delta)

	pass
