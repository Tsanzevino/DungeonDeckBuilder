extends Node

var room := preload("res://Scenes/Room.tscn")
var roomDimensions : Vector2i = Vector2i(1152,704)

var grid : Grid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stopwatch.start("maze gen")
	grid = PrimsAlgorithm.generate(Vector2i(5,5))
	for x in grid.dimensions.x:
		for y in grid.dimensions.y:
			pass
			var newRoom : Room = room.instantiate()
			newRoom.position.x = x * roomDimensions.x
			newRoom.position.y = y * roomDimensions.y
			newRoom.cell = grid.get_cell(Vector2i(x,y))
			newRoom.open_doors()
			add_child(newRoom)
	Stopwatch.stop("maze gen")
	grid.print_solution()
	close_doors_on_solution()
	add_chests()

func _process(_delta: float) -> void:
	var pos : Vector2 = get_tree().get_nodes_in_group("Player")[0].global_position
	var cell : Cell = grid.get_cell(floor(Vector2((pos.x + roomDimensions.x / 2) / roomDimensions.x, (pos.y + roomDimensions.y / 2) / roomDimensions.y)))
	cell.entered.emit()

func close_doors_on_solution():
	var solution := BFSSolver.solve(grid)
	for i in solution.size() - 2:
		var cell = grid.get_cell(solution[i])
		if cell.count_edges() > 2:
			var direction = solution[i + 1] - solution[i]
			match direction:
				Vector2i.UP: cell.close(Cell.Direction.NORTH)
				Vector2i.DOWN: cell.close(Cell.Direction.SOUTH)
				Vector2i.RIGHT: cell.close(Cell.Direction.EAST)
				Vector2i.LEFT: cell.close(Cell.Direction.WEST)

func add_chests():
	for x in grid.dimensions.x:
		for y in grid.dimensions.y:
			var coords = Vector2i(x,y)
			if grid.get_cell(coords).count_edges() == 1 && coords != Vector2i.ZERO:
				grid.get_cell(coords).add_chest.emit()

func test_rotate(cell : Cell):
	cell.print_edges()
	cell.rotate_counter_clockwise()
	cell.print_edges()
	cell.rotate_clockwise()
	cell.print_edges()

func test_direction(cell : Cell):
	cell.print_edges()
