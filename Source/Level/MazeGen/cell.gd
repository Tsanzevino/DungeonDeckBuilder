class_name Cell extends Object

enum Direction{NONE, WEST, SOUTH, SOUTH_WEST, EAST, WEST_EAST, SOUTH_EAST, NOT_NORTH, NORTH, NORTH_WEST, NORTH_SOUTH, NOT_EAST, NORTH_EAST, NOT_SOUTH, NOT_WEST, ALL}

var edges : int = 0
var _closed : int = 0
var mask : int = 0b1111
signal opened
signal closed
@warning_ignore("unused_signal")
signal add_chest
@warning_ignore("unused_signal")
signal entered

func _init(direction : Direction = Direction.NONE) -> void:
	set_edges(direction)

func has_edge(direction : Direction) -> bool:
	return direction & edges == direction

func set_edges(direction : Direction) -> void:
	edges = direction

func add_edges(direction : Direction) -> void:
	edges = edges | direction

func close(direction : Direction) -> void:
	_closed = _closed | direction
	closed.emit()

func open(direction : Direction) -> void:
	_closed = _closed & (~direction & mask)
	opened.emit()

func is_open(direction : Direction) -> bool:
	return (direction & ~_closed & mask) == direction

func rotate_clockwise() -> void:
	edges = (edges & 0b1110) >> 1 | (edges & 0b0001) << 3

func rotate_counter_clockwise() -> void:
	edges = (edges & 0b0111) << 1 | (edges & 0b1000) >> 3

func count_edges() -> int:
	return int(has_edge(Direction.NORTH)) + int(has_edge(Direction.EAST)) + int(has_edge(Direction.SOUTH)) + int(has_edge(Direction.WEST))

func has_closed_doors() -> bool:
	return _closed != 0

func _to_string() -> String:
	match edges:
		Direction.NONE: return " "
		Direction.EAST: return "\u257a"
		Direction.SOUTH: return "\u257b"
		Direction.SOUTH_EAST: return "\u250f"
		Direction.WEST: return "\u2578"
		Direction.WEST_EAST: return "\u2501"
		Direction.SOUTH_WEST: return "\u2513"
		Direction.NOT_NORTH: return "\u2533"
		Direction.NORTH: return "\u2579"
		Direction.NORTH_EAST: return "\u2517"
		Direction.NORTH_SOUTH: return "\u2503"
		Direction.NOT_WEST: return "\u2523"
		Direction.NORTH_WEST: return "\u251b"
		Direction.NOT_SOUTH: return "\u253b"
		Direction.NOT_EAST: return "\u252b"
		Direction.ALL: return "\u254b"
		_: return ""
