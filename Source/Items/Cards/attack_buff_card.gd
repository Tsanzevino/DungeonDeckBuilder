## A Card that applies effects to certain target cards.
class_name AttackBuffCard extends Card

## The effects to add to the target cards.
@export var buffEffects : Array[Buff]
## The types of cards being targetted.
@export var tagCondition : TagCondition

## Override of the superclass to force for the tag.
func _all_conditions_satisfied(entity : Entity) -> bool:
	return super(entity) and tagCondition.is_satisfied(entity)

## Applies the effects to the cards in the target position that have the specified tags.
func _perform_action(entity : Entity) -> void:
	for card in entity.deck.get_cards(tagCondition.target):
		if not ((card is AttackCard) and tagCondition.test_card(card)): continue
		for effect in buffEffects:
			var newEffect : Effect = effect.duplicate()
			(card as AttackCard).attack.damage.add_effect(newEffect)
			entity.attack_finished.connect(newEffect.update_expiration)
