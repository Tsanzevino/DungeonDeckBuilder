class_name Player extends CharacterBody2D

@export var deck : Deck

func _ready() -> void:
	deck.setup(self)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("use_card_1"):
		deck.play_card(0)
	if Input.is_action_just_pressed("use_card_2"):
		deck.play_card(1)
	if Input.is_action_just_pressed("use_card_3"):
		deck.play_card(2)
	if Input.is_action_just_pressed("use_card_4"):
		deck.play_card(3)
	if Input.is_action_just_pressed("use_card_5"):
		deck.play_card(4)
