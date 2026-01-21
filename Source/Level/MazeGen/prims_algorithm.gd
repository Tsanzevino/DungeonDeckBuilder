class_name PrimsAlgorithm extends MazeGenerator

static func generate(dimensions : Vector2i, startingCell : Vector2i) -> Grid:
	var grid : Grid = Grid.new(dimensions)
	var closedSet : Dictionary[Vector2i, bool] = {}
	var frontier : Dictionary[Vector2i, bool] = {}
	update_sets(startingCell, frontier, closedSet, dimensions)
	while frontier.size() > 0:
		var chosenCell := pick_cell(frontier)
		var direction := pick_direction(chosenCell,closedSet,dimensions)
		match direction:
			Vector2i.LEFT: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.NORTH)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.SOUTH)
			Vector2i.RIGHT: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.SOUTH)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.NORTH)
			Vector2i.DOWN: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.EAST)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.WEST)
			Vector2i.UP: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.WEST)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.EAST)
		update_sets(chosenCell,frontier,closedSet,dimensions)
	return grid

static func pick_direction(chosenCell : Vector2i, closedSet : Dictionary[Vector2i, bool], dimensions : Vector2i) -> Vector2i:
	var d := randi() % 4
	var direction : Vector2i
	match d:
		0: direction = Vector2i.UP
		1: direction = Vector2i.DOWN
		2: direction = Vector2i.LEFT
		3: direction = Vector2i.RIGHT
	if coordinate_is_valid_and_closed(chosenCell + direction, closedSet,dimensions): return direction
	direction *= -1
	if coordinate_is_valid_and_closed(chosenCell + direction, closedSet,dimensions): return direction
	var temp = direction.x
	direction.x = direction.y
	direction.y = temp
	if coordinate_is_valid_and_closed(chosenCell + direction, closedSet,dimensions): return direction
	direction *= -1
	if coordinate_is_valid_and_closed(chosenCell + direction, closedSet,dimensions): return direction
	return Vector2i.ZERO

static func pick_cell(frontier : Dictionary[Vector2i, bool]) -> Vector2i:
	return frontier.keys()[randi() % frontier.size()]

static func update_sets(chosenCell : Vector2i, frontier : Dictionary[Vector2i, bool], closedSet : Dictionary[Vector2i, bool], dimensions : Vector2i):
	closedSet[chosenCell] = true
	frontier.erase(chosenCell)
	if coordinate_is_valid_and_open(chosenCell + Vector2i.UP, closedSet,dimensions): frontier[chosenCell + Vector2i.UP] = true
	if coordinate_is_valid_and_open(chosenCell + Vector2i.DOWN, closedSet,dimensions): frontier[chosenCell + Vector2i.DOWN] = true
	if coordinate_is_valid_and_open(chosenCell + Vector2i.LEFT, closedSet,dimensions): frontier[chosenCell + Vector2i.LEFT] = true
	if coordinate_is_valid_and_open(chosenCell + Vector2i.RIGHT, closedSet,dimensions): frontier[chosenCell + Vector2i.RIGHT] = true

static func coordinate_is_valid_and_open(coord : Vector2i, closedSet : Dictionary[Vector2i, bool], dimensions : Vector2i) -> bool:
	if coord.x < 0 or dimensions.x <= coord.x: return false
	if coord.y < 0 or dimensions.y <= coord.y: return false
	return not closedSet.has(coord)

static func coordinate_is_valid_and_closed(coord : Vector2i, closedSet : Dictionary[Vector2i, bool], dimensions : Vector2i) -> bool:
	if coord.x < 0 or dimensions.x <= coord.x: return false
	if coord.y < 0 or dimensions.y <= coord.y: return false
	return closedSet.has(coord)
