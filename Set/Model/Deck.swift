//
//  Deck.swift
//  Set
//
//  Created by malygam on 06/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import Foundation

struct Deck {

    //MARK: - Properties

    var cards = [Card]()
    var cardsLeft: Int {
        return cards.count
    }

    //MARK: - Functions

    init(){

		// Dispose as many cards as possible combinations of cards in the deck
        // Each card has a unique identifier beginning at 0
		var index = 0
        for shapeStyle in Card.ShapeStyle.allCases {
            for shapeColorStyle in Card.ShapeColorStyle.allCases {
                for shapeFillingStyle in Card.ShapeFillingStyle.allCases {
                    for numberOfShapes in Card.NumberOfShapes.allCases {
                        let card = Card(identifier: index, shapeStyle: shapeStyle, shapeColorStyle: shapeColorStyle, shapeFillingStyle: shapeFillingStyle, numberOfShapes: numberOfShapes)
                        cards.append(card)
                        index += 1
                    }
                }
            }
        }

		// Shuffle the cards
        self.shuffle()
    }

    private mutating func shuffle() {
        cards.shuffle()
    }

    mutating func getSomeCards(_ numberOfCards: Int) -> [Card] {
        var someCards = [Card]()
        for _ in 1...numberOfCards {
        	someCards.append(cards.remove(at: (self.cardsLeft - 1)))
        }
        return someCards
    }

}

//MARK: - Extensions


