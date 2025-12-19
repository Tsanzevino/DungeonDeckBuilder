extends CanvasLayer

var mana : Mana
var health : Health
var deck : Deck

func setup(m : Mana, h : Health, d : Deck):
	mana = m
	%Mana.max_value = mana.maxMana
	health = h
	%Health.max_value = health.maxHealth
	deck = d
	%DeckUserInterface.setup(deck)

func _process(_delta: float) -> void:
	#Display Mana
	%Mana.value = mana.mana
	#Display Health
	%Health.value = health.health
	#Display Deck
