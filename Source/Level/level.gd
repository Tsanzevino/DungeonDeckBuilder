class_name Level extends Node2D

var roomScene := preload("res://Scenes/Room.tscn")
var roomDimensions : Vector2i = Vector2i(1152,704)

var dimensions : Vector2i
var rooms : Array[Array]

func get_room(coordinates : Vector2i) -> Room:
	return rooms[coordinates.x][coordinates.y]

func has_room(coordinates : Vector2i) -> bool:
	if coordinates.x < 0 or dimensions.x <= coordinates.x: return false
	if coordinates.y < 0 or dimensions.y <= coordinates.y: return false
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stopwatch.start("maze gen")
	var grid : Grid = PrimsAlgorithm.generate(Vector2i(5,5))
	
	dimensions = grid.dimensions
	rooms.resize(dimensions.x)
	for x in dimensions.x:
		rooms[x].resize(dimensions.y)
		for y in dimensions.y:
			pass
			var newRoom : Room = roomScene.instantiate()
			newRoom.z_index = -1
			newRoom.position.x = x * roomDimensions.x
			newRoom.position.y = y * roomDimensions.y
			newRoom.cell = grid.get_cell(Vector2i(x,y))
			newRoom.open_doors()
			add_child(newRoom)
	Stopwatch.stop("maze gen")
	grid.print_solution()
	lock_doors_on_solution(grid)
	add_chests()

func _process(_delta: float) -> void:
	var pos : Vector2 = get_tree().get_nodes_in_group("Player")[0].global_position
	var room : Room = get_room(floor(Vector2((pos.x + roomDimensions.x / 2) / roomDimensions.x, (pos.y + roomDimensions.y / 2) / roomDimensions.y)))
	room.entered.emit()

func lock_doors_on_solution(grid : Grid):
	var solution := BFSSolver.solve(grid)
	for i in solution.size() - 1:
		var room := get_room(solution[i])
		if room.cell.count_edges() > 2:
			var direction = solution[i + 1] - solution[i]
			match direction:
				Vector2i.UP: room.lock_door(Cell.Direction.NORTH)
				Vector2i.DOWN: room.lock_door(Cell.Direction.SOUTH)
				Vector2i.RIGHT: room.lock_door(Cell.Direction.EAST)
				Vector2i.LEFT: room.lock_door(Cell.Direction.WEST)

func add_chests():
	for x in dimensions.x:
		for y in dimensions.y:
			var coords = Vector2i(x,y)
			if get_room(coords).cell.count_edges() == 1 && coords != Vector2i.ZERO:
				get_room(coords).add_chest()
