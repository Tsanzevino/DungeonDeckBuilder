## Conditions are meant to act as tests for certain states of the world.
## The only requirement for an extending class is that it tests something from the player.
@abstract class_name Condition extends Resource 

## Whether or not to invert the result of the condition. Very useful in certain scenarios.
@export var invert : bool = false

## This is the public function that is called when testing a condition. 
## It combines the implemented test function and invert to provide a bool result.
func is_satisfied(player : Player) -> bool:
	return _test(player) != invert

## This is the private implementation of the class.
## Allows for very open-ended testing for the state of the player and their hand.
@abstract func _test(player : Player) -> bool
