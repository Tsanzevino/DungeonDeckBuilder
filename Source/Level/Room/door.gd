class_name Door extends StaticBody2D

const TRAPPED_MASK : int = 0b0010
const LOCKED_MASK : int = 0b0001

@export var trappedTexture : Texture2D
@export var lockedTexture : Texture2D
@export var openTexture : Texture2D
@export var sprite : Sprite2D
@export var sensor : Sensor

## Flags representing reasons the door cannot be opened.
## Trapped: All doors are trapped until enemies are defeated.
## Locked: A locked door is locked until unlocked with a key.
var openFlags : int = 0b0

signal door_opened
signal door_entered(entity : Entity)

func _ready() -> void:
	sensor.interacted.connect(_on_interacted)

func lock_door(): 
	openFlags = openFlags | LOCKED_MASK
	update_texture()

func unlock_door():
	openFlags = openFlags & ~LOCKED_MASK
	update_texture()
	if door_is_open(): open_door()

func trap_door(): 
	openFlags = openFlags | TRAPPED_MASK
	update_texture()

func untrap_door():
	openFlags = openFlags & ~TRAPPED_MASK
	update_texture()
	if door_is_open(): open_door()

func door_is_open() -> bool:
	return openFlags

func open_door():
	door_opened.emit()
	(find_children("*","CollisionShape2D")[0] as CollisionShape2D).set_deferred("disabled", true)

func _on_interacted(entity : Entity):
	if openFlags & TRAPPED_MASK: 
		DebugLogger.info("Cannot enter door, it is trapped shut")
		return
	elif openFlags & LOCKED_MASK: 
		if entity.keys < 1:
			DebugLogger.info("Cannot enter door, not enough keys")
			return
		DebugLogger.info("Unlocked door!")
		entity.keys -= 1
		unlock_door()
	else: 
		DebugLogger.info("Entered Door!")
		door_entered.emit(entity)
		

func update_texture():
	if openFlags & TRAPPED_MASK: sprite.texture = trappedTexture
	elif openFlags & LOCKED_MASK: sprite.texture = lockedTexture
	else: sprite.texture = openTexture
