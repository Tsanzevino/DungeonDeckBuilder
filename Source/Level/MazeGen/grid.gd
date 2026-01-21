class_name Grid extends Object

var dimensions : Vector2i
var grid : Array[Array]

func _init(d : Vector2i) -> void:
	dimensions = d
	grid.resize(dimensions.x)
	for x in dimensions.x:
		grid[x].resize(dimensions.y)
		for y in dimensions.y:
			grid[x][y] = Cell.new()

func get_cell(coordinates : Vector2i) -> Cell:
	return grid[coordinates.x][coordinates.y]

func _to_string() -> String:
	var result = ""
	for x in dimensions.x:
		for y in dimensions.y:
			result += _get_char(Vector2i(x,y))
		result += "\n"
	return result

func _get_char(coordinates : Vector2i) -> String:
	var cell = get_cell(coordinates)
	match cell.edges:
		Cell.Direction.NONE: return " "
		Cell.Direction.EAST: return "\u257a"
		Cell.Direction.SOUTH: return "\u257b"
		Cell.Direction.SOUTH_EAST: return "\u250f"
		Cell.Direction.WEST: return "\u2578"
		Cell.Direction.WEST_EAST: return "\u2501"
		Cell.Direction.SOUTH_WEST: return "\u2513"
		Cell.Direction.NOT_NORTH: return "\u2533"
		Cell.Direction.NORTH: return "\u2579"
		Cell.Direction.NORTH_EAST: return "\u2517"
		Cell.Direction.NORTH_SOUTH: return "\u2503"
		Cell.Direction.NOT_WEST: return "\u2523"
		Cell.Direction.NORTH_WEST: return "\u251b"
		Cell.Direction.NOT_SOUTH: return "\u253b"
		Cell.Direction.NOT_EAST: return "\u252b"
		Cell.Direction.ALL: return "\u254b"
		_: return ""
