class_name Interactor extends Area2D

var _target : Interactable

func _ready() -> void:
	area_entered.connect(compare_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		interact()

func interact():
	pass

func compare_target(interactable : Interactable):
	if _target == null: _target = interactable
	
