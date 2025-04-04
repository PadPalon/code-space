class_name Command

func is_final():
    return has_method("run_final")

func get_text():
    pass

func start(ship: RigidBody2D, delta: float):
    pass

func run(ship: RigidBody2D, delta: float):
    pass

func is_finished(ship: RigidBody2D, delta: float):
    pass