class_name Command

static func build(_arguments: Array[String]):
	return []

func is_final():
	return has_method("run_final")

func get_text():
	pass

func start(_ship: RigidBody2D, _delta: float, _stats: ShipStats):
	pass

func run(_ship: RigidBody2D, _delta: float, _stats: ShipStats):
	pass

func is_finished(_ship: RigidBody2D, _delta: float, _stats: ShipStats):
	pass
