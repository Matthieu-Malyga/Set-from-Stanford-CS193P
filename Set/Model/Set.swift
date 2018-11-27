//
//  Set.swift
//  Set
//
//  Created by malygam on 06/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import Foundation

struct Set {

    var deck = Deck()
    let numberOfInitialCards = 12
	var displayedCards = [Card]()
    var selectedCards = [Card]()
    var score: Int

    init() {
        displayedCards = deck.getSomeCards(numberOfInitialCards)
        score = 0
    }

    mutating func selectACard(_ card: Card) {
        if selectedCards.count < 3, !selectedCards.contains(card) {
            selectedCards.append(card)
        } else if selectedCards.contains(card) {
            selectedCards.remove(at: selectedCards.firstIndex(of: card)!)
        }
    }

    mutating func dealThreeMoreCards() {
        // Remove selected cards from displayed cards and replace them with new cards from deck
        for (index, card) in displayedCards.enumerated().reversed() {
            if selectedCards.contains(card) {
                if displayedCards.count <= 12, deck.cardsLeft > 0 {
                    displayedCards[index] = deck.getSomeCards(1)[0]
                } else {
                    displayedCards.remove(at: index)
                }
            }
        }

        // Remove selected cards
        selectedCards.removeAll()
    }

	// Checking if cards match per the rules of Set

    func selectedCardsMatch() -> Bool {
        if selectedCards.count == 3 {
			// Creates 4 arrays (for 4 different attributes that each card has) each containing the same attribute category for the 3 selected cards
			var shapeStyles = [Card.ShapeStyle]()
            var shapeColorStyles = [Card.ShapeColorStyle]()
            var shapeFillingStyles = [Card.ShapeFillingStyle]()
            var numberOfShapes = [Card.NumberOfShapes]()
            for card in selectedCards {
                shapeStyles.append(card.shapeStyle)
                shapeColorStyles.append(card.shapeColorStyle)
                shapeFillingStyles.append(card.shapeFillingStyle)
                numberOfShapes.append(card.numberOfShapes)
            }

            // Check if either 3 attributes match (are equal) or are all different. If either of these 2 conditions are met for each category of attributes, then it's a match.
            // The resulting algorithm is :
            // If all elements of the array are equal to the first element of this array
            // OR the product of each element is equal 6 (1 * 2 * 3). This is the only combinaison of values that gives a product of 6 :
            // 1 * 1 * 1 = 3
            // 2 * 2 * 2 = 8
            // 3 * 3 * 3 = 27
            // 1 * 2 * 2 = 4
            // 1 * 3 * 3 = 9 etc...

            // For TESTING purposes, always return true
			//return true

            if shapeStyles.allSatisfy({ $0 == shapeStyles[0] }) || shapeStyles.reduce(1, { $0 * $1.rawValue }) == 6 {
                if shapeColorStyles.allSatisfy({ $0 == shapeColorStyles[0] }) || shapeColorStyles.reduce(1, { $0 * $1.rawValue }) == 6 {
                    if shapeFillingStyles.allSatisfy({ $0 == shapeFillingStyles[0] }) || shapeFillingStyles.reduce(1, { $0 * $1.rawValue }) == 6 {
                        if numberOfShapes.allSatisfy({ $0 == numberOfShapes[0] }) || numberOfShapes.reduce(1, { $0 * $1.rawValue }) == 6 {
                            return true
                        }
                    }
                }
            }
            return false
        }
        return false
    }
}

//MARK: - Helper Methods
