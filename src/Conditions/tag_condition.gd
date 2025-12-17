## A Tag Condition is satisfied when the target card has the specified tag.
class_name TagCondition extends Condition

@export var tag : Tag

@export var target : Card

func is_satisfied() -> bool:
	return target.tags.has(tag)
