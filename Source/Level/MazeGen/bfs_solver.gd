class_name BFSSolver extends Object

static func solve(grid : Grid, start : Vector2i = Vector2i.ZERO, finish : Vector2i = Vector2i(-1,-1)) -> Array[Vector2i]:
	if finish == Vector2i(-1,-1):
		finish = grid.dimensions + finish
	return _solve_recursive(finish,{},start,grid)

static func _solve_recursive(currentCell : Vector2i, visited : Dictionary[Vector2i,bool], finish : Vector2i, grid : Grid) -> Array[Vector2i]:
	visited[currentCell] = true
	# if the current node is the finish, return the current cell
	if currentCell == finish: return [currentCell]
	# otherwise, return whichever recursive solve put finish in the visited set
	var dir = 1
	for coords in [currentCell + Vector2i.LEFT, currentCell + Vector2i.DOWN, currentCell + Vector2i.RIGHT, currentCell + Vector2i.UP]:
		if not visited.has(coords) and grid.get_cell(currentCell).has_edge(dir):
			var res = _solve_recursive(coords,visited,finish,grid)
			if visited.has(finish):
				res.append(currentCell)
				return res
		dir = dir << 1
	return []
