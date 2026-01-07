class_name CardUserInterface extends PanelContainer

var displayCard : Card

func _init(card : Card):
	displayCard = card

func _ready():
	var tex := TextureRect.new()
	tex.texture = displayCard.displayImage
	add_child(tex)

func update_card(card : Card):
	displayCard = card
	get_child(0).texture = displayCard.displayImage

func select_card():
	add_theme_stylebox_override("panel",preload("res://Data/selected_card.tres"))

func deselect_card():
	remove_theme_stylebox_override("panel")
