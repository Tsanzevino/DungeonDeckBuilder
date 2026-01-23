class_name Item extends Resource

## The name of the item.
@export var name : String = ""
## The item description.
@export var description : String = ""
## The image displayed for the item
@export var displayImage : Texture2D
## The tags this card has. Used to hold metadata about the card for effects and other cards.
@export var tags : Array[Tag] = []

## An enum for every kind of tag possible. 
## This avoids issues with strings such as misspellings, being similar but not identical, and being tedious.
enum Tag{FIRE,WATER,SPELL,MELEE,BOOST,KEY}
