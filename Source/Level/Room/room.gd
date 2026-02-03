@abstract
class_name Room extends Node2D

@export var doorScene : PackedScene = preload("res://Scenes/Door.tscn")
@export var wallScene : PackedScene = preload("res://Scenes/Wall.tscn")
@export var chestScene : PackedScene = preload("res://Scenes/Chest.tscn")

var cell : Cell

signal entered
signal door_exited

func _ready() -> void:
	assert(cell != null, "Cell must be assigned for Room to setup!")
	add_walls()
	add_doors()
	setup()

func add_walls():
	if not cell.has_edge(Cell.Direction.NORTH): get_north_wall().add_child(wallScene.instantiate())
	if not cell.has_edge(Cell.Direction.EAST): get_east_wall().add_child(wallScene.instantiate())
	if not cell.has_edge(Cell.Direction.SOUTH): get_south_wall().add_child(wallScene.instantiate())
	if not cell.has_edge(Cell.Direction.WEST): get_west_wall().add_child(wallScene.instantiate())

func add_doors():
	if cell.has_edge(Cell.Direction.NORTH): get_north_wall().add_child(doorScene.instantiate())
	if cell.has_edge(Cell.Direction.EAST): get_east_wall().add_child(doorScene.instantiate())
	if cell.has_edge(Cell.Direction.SOUTH): get_south_wall().add_child(doorScene.instantiate())
	if cell.has_edge(Cell.Direction.WEST): get_west_wall().add_child(doorScene.instantiate())

func lock_door(direction : Cell.Direction):
	var wall : Node2D
	match direction:
		Cell.Direction.NORTH: wall = get_north_wall()
		Cell.Direction.EAST: wall = get_east_wall()
		Cell.Direction.SOUTH: wall = get_south_wall()
		Cell.Direction.WEST: wall = get_west_wall()
	(wall.find_children("*","Door")[0] as Door).lock_door()

func add_chest():
	get_chest_parent().add_child(chestScene.instantiate())

## Room specific setup function. Used to build the room-specific aspects
@abstract func setup()

@abstract func get_north_wall() -> Node2D
@abstract func get_east_wall() -> Node2D
@abstract func get_west_wall() -> Node2D
@abstract func get_south_wall() -> Node2D
@abstract func get_chest_parent() -> Node2D
