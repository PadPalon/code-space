class_name RotationUtils

static func to_360(rotation: float):
	if rotation < 0:
		return int(360 - abs(rotation))
	if rotation >= 360:
		return int(fposmod(rotation, 360))
	return int(rotation)


static func to_180(rotation: int):
	if rotation > 180:
		return (360 - rotation) * -1
	return rotation


static func distance_left(source: int, target: int):
	if target < source:
		return source - target
	if target > source:
		return 360 - distance_right(source, target)
	return 0


static func distance_right(source: int, target: int):
	if target < source:
		return 360 - distance_left(source, target)
	if target > source:
		return target - source
	return 0
