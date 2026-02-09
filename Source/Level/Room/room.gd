@abstract
class_name Room extends Node2D

var chestScene : PackedScene = preload("res://Scenes/Chest.tscn")

var cell : Cell
var level : Level
var alreadyCleared : bool = false

signal room_cleared
signal leave_room(direction : Cell.Direction)

func _process(_delta: float) -> void:
	if not alreadyCleared and test_room_cleared(): 
		alreadyCleared = true
		room_cleared.emit()

func _ready() -> void:
	assert(cell != null, "Cell must be assigned for Room to setup!")
	assert(level != null, "Level must be assigned for Room to setup!")
	room_cleared.connect(clear_room)
	setup_doors()
	setup()

func setup_doors():
	setup_door(get_north_door(), Cell.Direction.NORTH)
	setup_door(get_east_door(), Cell.Direction.EAST)
	setup_door(get_south_door(), Cell.Direction.SOUTH)
	setup_door(get_west_door(), Cell.Direction.WEST)

func setup_door(door : Door, dir : Cell.Direction):
	door.door_entered.connect(func(_entity : Entity): leave_room.emit(dir))
	if cell.has_edge(dir): door.trap_door()
	else: door.make_wall()

func lock_door(direction : Cell.Direction):
	match direction:
		Cell.Direction.NORTH: get_north_door().lock_door()
		Cell.Direction.EAST: get_east_door().lock_door()
		Cell.Direction.SOUTH: get_south_door().lock_door()
		Cell.Direction.WEST: get_west_door().lock_door()

func clear_room():
	get_north_door().untrap_door()
	get_east_door().untrap_door()
	get_west_door().untrap_door()
	get_south_door().untrap_door()

func add_chest():
	room_cleared.connect(create_chest)

func create_chest():
	get_chest_parent().add_child(chestScene.instantiate())
	room_cleared.disconnect(create_chest)

## Room specific setup function. Used to build the room-specific aspects
@abstract func setup() -> void

@abstract func get_north_door() -> Door
@abstract func get_east_door() -> Door
@abstract func get_west_door() -> Door
@abstract func get_south_door() -> Door
@abstract func get_chest_parent() -> Node2D
@abstract func get_player_spawn(direction : Cell.Direction) -> Vector2
@abstract func test_room_cleared() -> bool
