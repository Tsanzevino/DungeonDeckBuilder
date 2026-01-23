class_name Room extends Node2D

var cell : Cell

func _ready() -> void:
	cell.opened.connect(open_doors)
	cell.closed.connect(close_doors)
	cell.add_chest.connect(add_chest)
	cell.entered.connect(update)
	open_doors()

func add_chest():
	add_child(preload("res://Scenes/Chest.tscn").instantiate())

func update():
	if get_tree().get_first_node_in_group("Player").keys > 0 and cell.has_closed_doors():
		print("opened door")
		get_tree().get_first_node_in_group("Player").keys -= 1
		cell._closed = 0
		open_doors()

func open_doors() -> void:
	if cell.has_edge(Cell.Direction.NORTH): %NorthWall.get_child(0).disabled = true
	if cell.has_edge(Cell.Direction.EAST): %EastWall.get_child(0).disabled = true
	if cell.has_edge(Cell.Direction.SOUTH): %SouthWall.get_child(0).disabled = true
	if cell.has_edge(Cell.Direction.WEST): %WestWall.get_child(0).disabled = true

func close_doors() -> void:
	if not cell.is_open(Cell.Direction.NORTH): %NorthWall.get_child(0).disabled = false
	if not cell.is_open(Cell.Direction.EAST): %EastWall.get_child(0).disabled = false
	if not cell.is_open(Cell.Direction.SOUTH): %SouthWall.get_child(0).disabled = false
	if not cell.is_open(Cell.Direction.WEST): %WestWall.get_child(0).disabled = false

func open_door(direction : Cell.Direction) -> void:
	if not cell.has_edge(direction): return
	if direction == Cell.Direction.NORTH: %NorthWall.get_child(0).disabled = true
	if direction == Cell.Direction.EAST: %EastWall.get_child(0).disabled = true
	if direction == Cell.Direction.SOUTH: %SouthWall.get_child(0).disabled = true
	if direction == Cell.Direction.WEST: %WestWall.get_child(0).disabled = true

func close_door(direction : Cell.Direction) -> void:
	if direction == Cell.Direction.NORTH: %NorthWall.get_child(0).disabled = false
	if direction == Cell.Direction.EAST: %EastWall.get_child(0).disabled = false
	if direction == Cell.Direction.SOUTH: %SouthWall.get_child(0).disabled = false
	if direction == Cell.Direction.WEST: %WestWall.get_child(0).disabled = false
