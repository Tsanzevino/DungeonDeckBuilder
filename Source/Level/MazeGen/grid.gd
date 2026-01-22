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
	for y in dimensions.y:
		for x in dimensions.x:
			result += get_cell(Vector2i(x,y)).to_string()
		result += "\n"
	return result

func has_cell(coordinates : Vector2i) -> bool:
	if coordinates.x < 0 or dimensions.x <= coordinates.x: return false
	if coordinates.y < 0 or dimensions.y <= coordinates.y: return false
	return true

func print_solution(start : Vector2i = Vector2i.ZERO, finish : Vector2i = Vector2i(-1,-1)) -> void:
	if finish == Vector2i(-1,-1):
		finish = dimensions + finish
	var solution : Array[Vector2i] = BFSSolver.solve(self,start,finish)
	var result = ""
	for y in dimensions.y:
		for x in dimensions.x:
			var coords = Vector2i(x,y)
			if solution.has(coords):
				result += get_cell(Vector2i(x,y)).to_string()
			else: result += " "
		result += "\n"
	print(result)
