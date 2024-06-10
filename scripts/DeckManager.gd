extends Node
class_name DeckManager

signal card_drawn

@export var ric_cards: Array[Card]
@export var ego_cards: Array[Card]
@export var pre_cards: Array[Card]
@export var tol_cards: Array[Card]
@export var net_cards: Array[Card]
@export var end_cards: Array[Card]

var RIC_DECK: Deck = Deck.new(Deck.DECK_TYPES.RIC, ric_cards)
var EGO_DECK: Deck = Deck.new(Deck.DECK_TYPES.EGO, ego_cards)
var PRE_DECK: Deck = Deck.new(Deck.DECK_TYPES.PRE, pre_cards)
var TOL_DECK: Deck = Deck.new(Deck.DECK_TYPES.TOL, tol_cards)
var NET_DECK: Deck = Deck.new(Deck.DECK_TYPES.NET, net_cards)
var END_DECK: Deck = Deck.new(Deck.DECK_TYPES.END, end_cards)

func draw_card(deck: Deck, player: Player) -> String:
		var card: String
		
		card_drawn.emit()
		return card
