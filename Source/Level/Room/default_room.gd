extends Room

func setup() -> void:
	pass

func get_player_spawn(direction : Cell.Direction):
	var offset : Vector2 = Cell.direction_to_vector(direction) * 64
	match direction:
		Cell.Direction.SOUTH: return get_north_door().global_position + offset
		Cell.Direction.WEST: return get_east_door().global_position + offset
		Cell.Direction.NORTH: return get_south_door().global_position + offset
		Cell.Direction.EAST: return get_west_door().global_position + offset

func test_room_cleared() -> bool:
	return %Enemies.get_child_count() == 0

func get_north_door() -> Door: return %NorthDoor
func get_east_door() -> Door: return %EastDoor
func get_south_door() -> Door: return %SouthDoor
func get_west_door() -> Door: return %WestDoor
func get_chest_parent() -> Node2D: return self
