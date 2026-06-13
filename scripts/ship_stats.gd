class_name ShipStats extends Resource

@export var thrust: float
@export var rotation_speed: float

func _init(thrust_argument = 0, rotation_speed_argument = 0):
	thrust = thrust_argument
	rotation_speed = rotation_speed_argument
