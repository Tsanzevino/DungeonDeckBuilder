class_name Cell extends Object

enum Direction{NONE, WEST, SOUTH, SOUTH_WEST, EAST, WEST_EAST, SOUTH_EAST, NOT_NORTH, NORTH, NORTH_WEST, NORTH_SOUTH, NOT_EAST, NORTH_EAST, NOT_SOUTH, NOT_WEST, ALL}

const EDGE_MASK = 0b1111
var edges : int = 0

func _init(direction : Direction = Direction.NONE) -> void:
	set_edges(direction)

func has_edge(direction : Direction) -> bool:
	return (direction & edges) & EDGE_MASK == direction & EDGE_MASK

func set_edges(direction : Direction) -> void:
	edges = direction & EDGE_MASK

func add_edges(direction : Direction) -> void:
	edges = (edges & EDGE_MASK) | (direction & EDGE_MASK)

func rotate_clockwise() -> void:
	edges = (edges & Direction.NOT_WEST) >> 1 | (edges & Direction.WEST) << 3

func rotate_counter_clockwise() -> void:
	edges = (edges & Direction.NOT_NORTH) << 1 | (edges & Direction.NORTH) >> 3

func count_edges() -> int:
	return int(has_edge(Direction.NORTH)) + int(has_edge(Direction.EAST)) + int(has_edge(Direction.SOUTH)) + int(has_edge(Direction.WEST))

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

static func vector_to_direction(vector : Vector2) -> Direction:
	match vector:
		Vector2.UP: return Direction.NORTH
		Vector2.DOWN: return Direction.SOUTH
		Vector2.LEFT: return Direction.WEST
		Vector2.RIGHT: return Direction.EAST
		_: return Direction.NONE

static func direction_to_vector(direction : Direction) -> Vector2i:
	match direction:
		Direction.NORTH: return Vector2i.UP
		Direction.SOUTH: return Vector2i.DOWN
		Direction.WEST: return Vector2i.LEFT 
		Direction.EAST: return Vector2i.RIGHT
		_: return Vector2i.ZERO
