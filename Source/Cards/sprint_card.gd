## A card that adds sprint duration to the player.
class_name SprintCard extends Card

## The amount of sprint duration added.
@export var duration : float

## Adds sprint duration.
func _perform_action(player : Player) -> void:
	player.add_sprint_duration(duration)
