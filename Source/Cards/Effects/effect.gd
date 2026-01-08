@abstract
class_name Effect extends Resource

@abstract func apply(card : Card) -> void

@abstract func remove(card : Card) -> void

@abstract func is_expired() -> bool
