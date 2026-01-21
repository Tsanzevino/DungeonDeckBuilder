extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var grid : Grid = PrimsAlgorithm.generate(Vector2i(40,40),Vector2i(0,3))
	print(grid)

func test_rotate(cell : Cell):
	cell.print_edges()
	cell.rotate_counter_clockwise()
	cell.print_edges()
	cell.rotate_clockwise()
	cell.print_edges()

func test_direction(cell : Cell):
	cell.print_edges()
