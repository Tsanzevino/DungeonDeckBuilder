class_name Level extends Node2D

var roomScenes : Array = [preload("res://Scenes/Room.tscn"),preload("res://Scenes/Room_Two.tscn")]

var dimensions : Vector2i
var rooms : Array[Array]
var solution : Array[Vector2i]
var currentRoomCoords : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grid : Grid = PrimsAlgorithm.generate(Vector2i(5,5))
	solution = BFSSolver.solve(grid)
	dimensions = grid.dimensions
	load_rooms(grid)
	currentRoomCoords = Vector2i.ZERO
	enter_room(_get_room(currentRoomCoords),Cell.Direction.SOUTH)

func load_rooms(grid : Grid):
	rooms.resize(dimensions.x)
	for x in dimensions.x:
		rooms[x].resize(dimensions.y)
		for y in dimensions.y:
			var newRoom : Room = roomScenes[randi() % roomScenes.size()].instantiate()
			newRoom.cell = grid.get_cell(Vector2i(x,y))
			newRoom.level = self
			rooms[x][y] = newRoom
	lock_doors_on_solution()
	add_chests()

func lock_doors_on_solution():
	for i in solution.size() - 1:
		var room := _get_room(solution[i])
		if room.cell.count_edges() > 2:
			var direction : = Cell.vector_to_direction(solution[i + 1] - solution[i])
			room.lock_door(direction)

func add_chests():
	for x in dimensions.x:
		for y in dimensions.y:
			var coords = Vector2i(x,y)
			if _get_room(coords).cell.count_edges() == 1 && coords != Vector2i.ZERO:
				_get_room(coords).add_chest()

func enter_room(room : Room, direction : Cell.Direction):
	add_child(room)
	(find_children("*","Player")[0] as Player).global_position = room.get_player_spawn(direction)
	room.leave_room.connect(change_rooms)

func exit_room(room : Room):
	room.leave_room.disconnect(change_rooms)
	remove_child(room)

func change_rooms(direction : Cell.Direction):
	var currentRoom : Room = _get_room(currentRoomCoords)
	currentRoomCoords += Cell.direction_to_vector(direction)
	var newRoom : Room = _get_room(currentRoomCoords)
	exit_room(currentRoom)
	enter_room(newRoom,direction)

func _get_room(coordinates : Vector2i) -> Room:
	return rooms[coordinates.x][coordinates.y]
