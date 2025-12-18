class_name Health extends Node

@export var maxHealth : float

var health : float :
	get(): return health
	set(value):
		health += value
		health = clampf(health, 0, maxHealth)
		if health == maxHealth: at_max_health.emit()
		if health == 0: at_no_heath.emit()

signal at_max_health
signal at_no_heath
