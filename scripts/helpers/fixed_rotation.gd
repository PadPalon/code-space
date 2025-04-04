extends Camera2D

@export var target_rotation: float

func _process(delta):  
	global_rotation_degrees = target_rotation
