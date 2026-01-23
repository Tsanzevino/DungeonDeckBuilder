class_name DiscardHandCard extends Card

func _perform_action(entity : Entity) -> void:
	entity.deck.discard_hand(self)
