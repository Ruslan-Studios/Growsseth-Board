extends Resource
class_name CardData

enum CARD_TYPES { T, TS, S }

@export var deck_type: Deck.DECK_TYPES
@export var id: int
@export var card_name: String
@export var card_type: CARD_TYPES
@export_multiline var lore: String
@export_multiline var description: String
@export var artwork: CompressedTexture2D

var cardObj = preload("res://scenes/components/CardObj.tscn")
