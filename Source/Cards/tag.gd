class_name Tag extends Resource

@export var tagName : String = ""

func equals(tag : Tag) -> bool:
	return tagName == tag.tagName
