class_name PrimsAlgorithm extends Object

static func generate(dimensions : Vector2i, startingCell : Vector2i = Vector2i(-1,-1)) -> Grid:
	if startingCell == Vector2i(-1,-1):
		startingCell = dimensions / 2
	var grid : Grid = Grid.new(dimensions)
	var closedSet : Dictionary[Vector2i, Vector2i] = {}
	var frontier : Dictionary[Vector2i, Vector2i] = {startingCell : startingCell}
	update_sets(startingCell, frontier, closedSet, dimensions)
	while frontier.size() > 0:
		var chosenCell := pick_cell(frontier)
		var direction := frontier[chosenCell] - chosenCell
		match direction:
			Vector2i.UP: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.NORTH)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.SOUTH)
			Vector2i.DOWN: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.SOUTH)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.NORTH)
			Vector2i.RIGHT: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.EAST)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.WEST)
			Vector2i.LEFT: 
				grid.get_cell(chosenCell).add_edges(Cell.Direction.WEST)
				grid.get_cell(chosenCell + direction).add_edges(Cell.Direction.EAST)
		update_sets(chosenCell,frontier,closedSet,dimensions)
	return grid

static func pick_cell(frontier : Dictionary[Vector2i, Vector2i]) -> Vector2i:
	return frontier.keys()[randi() % frontier.size()]

static func update_sets(chosenCell : Vector2i, frontier : Dictionary[Vector2i, Vector2i], closedSet : Dictionary[Vector2i, Vector2i], dimensions : Vector2i):
	closedSet[chosenCell] = frontier[chosenCell]
	frontier.erase(chosenCell)
	if coordinate_is_valid_and_open(chosenCell + Vector2i.UP, closedSet,dimensions): frontier[chosenCell + Vector2i.UP] = chosenCell
	if coordinate_is_valid_and_open(chosenCell + Vector2i.DOWN, closedSet,dimensions): frontier[chosenCell + Vector2i.DOWN] = chosenCell
	if coordinate_is_valid_and_open(chosenCell + Vector2i.LEFT, closedSet,dimensions): frontier[chosenCell + Vector2i.LEFT] = chosenCell
	if coordinate_is_valid_and_open(chosenCell + Vector2i.RIGHT, closedSet,dimensions): frontier[chosenCell + Vector2i.RIGHT] = chosenCell

static func coordinate_is_valid_and_open(coord : Vector2i, closedSet : Dictionary[Vector2i, Vector2i], dimensions : Vector2i) -> bool:
	if coord.x < 0 or dimensions.x <= coord.x: return false
	if coord.y < 0 or dimensions.y <= coord.y: return false
	return not closedSet.has(coord)

static func coordinate_is_valid_and_closed(coord : Vector2i, closedSet : Dictionary[Vector2i, Vector2i], dimensions : Vector2i) -> bool:
	if coord.x < 0 or dimensions.x <= coord.x: return false
	if coord.y < 0 or dimensions.y <= coord.y: return false
	return closedSet.has(coord)
