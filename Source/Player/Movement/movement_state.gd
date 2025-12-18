@abstract class_name MovementState extends State

const WALK_SPEED : float = 200.0
const SPRINT_SPEED : float = 400.0
const GROUND_FRICTION : float = 15
const DEADZONE_SIZE : float = 0.1

const IDLE := "Idle"
const SPRINTING := "Sprinting"
const WALKING := "Walking"

var player : CharacterBody2D
var direction : Vector2

func handle_input(_event: InputEvent) -> void: pass

func update(_delta : float) -> void:
	var input_dir : Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	direction = input_dir.normalized()
