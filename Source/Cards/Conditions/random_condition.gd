## A random chance condition to simulate rolling dice, or other random events.
class_name RandomCondition extends Condition

## The percent chance of success. 0 will never(probably) happen, and 1 will always(definitely) happen.[br]
## [b]NOTE:[/b] Setting chance to 0 is still technically possible, so if for whatever reason you want something to never ever happen,
## invert a chance of 1.0.
@export_range(0.0,1.0,0.01) var chance : float = 0.5

func _test(_player : Player) -> bool:
	return randf() <= chance
