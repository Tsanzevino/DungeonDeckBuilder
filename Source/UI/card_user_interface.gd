class_name CardUserInterface extends PanelContainer

var displayCard : Card

func _init(card : Card):
	displayCard = card

func _ready():
	var tex := TextureRect.new()
	tex.texture = displayCard.displayImage
	tex.custom_minimum_size = Vector2(128,128)
	add_child(tex)

func update_card(card : Card):
	displayCard = card
	get_child(0).texture = displayCard.displayImage

func select_card():
	add_theme_stylebox_override("panel",preload("res://Data/Items/Cards/selected_card.tres"))

func deselect_card():
	remove_theme_stylebox_override("panel")
