class_name Cell extends Object

enum Direction{NONE, WEST, SOUTH, SOUTH_WEST, EAST, WEST_EAST, SOUTH_EAST, NOT_NORTH, NORTH, NORTH_WEST, NORTH_SOUTH, NOT_EAST, NORTH_EAST, NOT_SOUTH, NOT_WEST, ALL}

var edges : int = 0

func _init(direction : Direction = Direction.NONE) -> void:
	set_edges(direction)

func has_edge(direction : Direction) -> bool:
	return direction & edges == direction

func set_edges(direction : Direction) -> void:
	edges = direction

func add_edges(direction : Direction) -> void:
	edges = edges | direction

func rotate_clockwise() -> void:
	edges = (edges & 0b1110) >> 1 | (edges & 0b0001) << 3

func rotate_counter_clockwise() -> void:
	edges = (edges & 0b0111) << 1 | (edges & 0b1000) >> 3

func print_edges() -> void:
	var result : String = ""
	if has_edge(Direction.NORTH): result = result + "North "
	if has_edge(Direction.EAST): result = result + "East "
	if has_edge(Direction.SOUTH): result = result + "South "
	if has_edge(Direction.WEST): result = result + "West "
	print(result)
