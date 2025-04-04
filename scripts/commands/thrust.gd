class_name Thrust extends Command

var target_burn
var burn_time = 0

func _init(arguments: Array):
    var length = arguments[0]
    target_burn = int(length)

func get_text():
    return "THRUST " + str(target_burn) + " SECONDS"

func run(ship: RigidBody2D, delta: float):
    ship.apply_central_force(Vector2.from_angle(ship.rotation) * delta * 300)
    burn_time += delta

func is_finished(ship: RigidBody2D, delta: float):
    var burn_finished = burn_time >= target_burn
    return burn_finished
