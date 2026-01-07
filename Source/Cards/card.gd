@abstract
class_name Card extends Resource

@export var name : String = ""
@export var description : String = ""
@export var manaCost : float = 0.0
@export var displayImage : Texture2D

@export var tags : Array[Tag] = []

## Attempts to play the card. Returns true if the card was successfully played and can be discarded.
## Returns false if a condition was not met that prevents it from being played.
@abstract func play(player : Player) -> bool

func consume_mana(player : Player) -> bool:
	return player.mana.consume(manaCost)

enum Tag{BROKEN,FIRE,WATER,SPELL,MELEE}
