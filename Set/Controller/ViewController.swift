//
//  ViewController.swift
//  Set
//
//  Created by malygam on 06/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

//TODO: 1 - Gérer la fin du jeu : quand plus de cartes dans le deck -> faire disparaître les cartes matchées plutôt que de les remplacer par des cartes du deck (puisqu'il n'y en a plus)

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties

    private var game = Set()

    var cardViews = [CardView]() {
        didSet {
            for cardView in cardViews {
                if cardView.gestureRecognizers == nil {
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCard(recognizer:)))
                    cardView.addGestureRecognizer(tapGestureRecognizer)
                }
            }
        }
    }

    //MARK: - Outlets

    @IBOutlet weak var cardsBoardView: CardsBoardView!
    @IBOutlet weak var discardPileView: DiscardPileView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealButton: DealButton!
    
    //MARK: - Actions

    @IBAction func dealThreeMoreCards() {
		dealThreeCards()
    }

	//MARK: - Functions

    @objc func selectCard(recognizer: UITapGestureRecognizer) {
        game.selectACard(getCardFromCardView(recognizer.view as! CardView))
        updateView()
    }

    func dealThreeCards() {
        // If cards match then replace them with 3 new cards
        if game.selectedCardsMatch() {
            // If there are 12 displayed cards
            if cardViews.count == 12 {
                // We go through each of the 12 card views
                for cardView in cardViews {
                    // If a card view is a matching card, let's make it reappear by :
                    // 1 - Reset its alpha to 1
                    // 2 - Dealing 3 new cards with "game.dealThreeMoreCards()" at the end of this if/else
                    // 3 - updating the view at the very end of the self.dealThreeCards function
                    if cardView.isMatched {
                        Timer.scheduledTimer(withTimeInterval: indexOfSelectedCard(fromCardView: cardView)*0.3, repeats: false, block: { _ in
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.3,
                                delay: 0,
                                options: [],
                                animations: {
                                    cardView.isMatched = false
                                    cardView.isSelected = false
                                    cardView.alpha = 1
                                    cardView.layer.zPosition = 0.1
                                    cardView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            },
                                completion: { position in
                                    UIViewPropertyAnimator.runningPropertyAnimator(
                                        withDuration: 0.4,
                                        delay: 0,
                                        options: [],
                                        animations: {
                                            cardView.transform = .identity
                                    	},
                                        completion: { position in
                                            cardView.layer.zPosition = 0.0
                                    	}
                                    )
                            }
                            )
                        })
                    }
                }
            // If selected cards match and there are more than 12 displayed cards
            } else {
                for cardView in cardViews {
                    if cardView.isMatched {
                        cardView.removeFromSuperview()
                    }
                }
                cardViews.removeAll(where: { $0.isMatched })
            }
            // This function removes selected cards from displayed cards and replaces them with new cards from deck
            game.dealThreeMoreCards()

            updateView()
        // If cards don't match or no cards selected then add 3 more cards until full screen
        } else {
			game.displayedCards.append(contentsOf: game.deck.getSomeCards(3))
            for _ in 1...3 {
                let cardView = CardView()
                cardViews.append(cardView)
                // Adds the cardView as cardsBoard subviews
                cardsBoardView.addSubview(cardView)
            }

            cardsBoardView.numberOfCardsToBeDisplayed = game.displayedCards.count

            for cardView in cardViews[..<(cardViews.count - 3)] {
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.7,
                    delay: 0,
                    options: [],
                    animations: {
                        cardView.frame = self.cardsBoardView.grid[self.cardViews.index(of: cardView)!]!.insetBy(dx: 5.0, dy: 5.0)
                    }
                )
            }

            for cardView in self.cardViews[(self.cardViews.count-3)...] {
                cardView.center = dealButton.convert(dealButton.center, to: cardsBoardView)
            }

            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { _ in
                var animationCounter = 0.0
                for cardView in self.cardViews[(self.cardViews.count-3)...] {
                    Timer.scheduledTimer(withTimeInterval: animationCounter*0.5, repeats: false, block: { _ in
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 1.2,
                            delay: 0,
                            options: [],
                            animations: {
                                cardView.frame = self.cardsBoardView.grid[self.cardViews.index(of: cardView)!]!.insetBy(dx: 5.0, dy: 5.0)
								self.drawCardView(cardView)
                        	}
                        )
                    })
                    animationCounter += 1.0
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }

    func newGame() {
        // Initiate a new game
        game = Set()

        // Removes eventually existing cardViews from viewController (self) property
        cardViews.removeAll()

        // Removes eventually existing cardViews from its superview (the cardsBoardView)
        for cardView in cardsBoardView.subviews {
            cardView.removeFromSuperview()
        }

        // Sets the grid number of cells based on the number of cards to be displayed
        cardsBoardView.numberOfCardsToBeDisplayed = game.displayedCards.count

        // Creates new cardViews and add them as cardBoardView subviews
		for index in game.displayedCards.indices {
            let cardView = CardView()
			cardViews.append(cardView)
            // Adds the cardView as cardsBoard subviews
            cardsBoardView.addSubview(cardView)

            // Sets the card design to be drawn
            drawCardView(cardView)

            // Pre-animation preparation
            cardView.frame = cardsBoardView.grid[0]!.insetBy(dx: 10.0, dy: 10.0)
            cardView.center = cardsBoardView.center
            cardView.alpha = 0

            Timer.scheduledTimer(withTimeInterval: Double(index)*0.15, repeats: false, block: { _ in
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.7,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: {
                        cardView.frame = self.cardsBoardView.grid[index]!.insetBy(dx: 5.0, dy: 5.0)
                        cardView.alpha = 1
                }
                )
            })
        }
    }

    func updateView() {
		// Counts the number of cards marked as matching so that the score is incremented only once per Sets (instead of incrementing the score once per card highlighted which would increase the score by 3 instead of 1)
        var numberOfCardsHighlighted = 0.0

        // Sets the grid number of cells based on the number of cards to be displayed
        cardsBoardView.numberOfCardsToBeDisplayed = game.displayedCards.count

		// For each cardView, show it if displayed, draw the shape, show the selected cards
        for index in game.displayedCards.indices {

            // Sets the card design to be drawn
            drawCardView(cardViews[index])

            // Sets the card's view frame base on number of cards (grid)
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.7,
                delay: 0,
                options: [],
                animations: {
                	self.cardViews[index].frame = self.cardsBoardView.grid[index]!.insetBy(dx: 5.0, dy: 5.0)
                }
            )

			// Strokes the selected cards
            if game.selectedCards.contains(game.displayedCards[index]) {
                cardViews[index].isSelected = true
                // If selected cards match, highlight them
                if game.selectedCardsMatch() {
                    cardViews[index].isMatched = true
                    // We use this index of selected card for the animation. We want the three matching cards to disappear one AFTER another
                    Timer.scheduledTimer(withTimeInterval: indexOfSelectedCard(fromCardView: cardViews[index])*0.3, repeats: false, block: { _ in
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: 0.7,
                            delay: 0,
                            options: [],
                            animations: {
								// Card Views disappear
                                self.cardViews[index].alpha = 0
                                self.cardViews[index].transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                //TODO: Correct the dealButton usage here
                                self.cardViews[index].center = self.discardPileView.convert(self.dealButton.center, to: self.cardsBoardView)
                                //self.cardViews[index].center = self.discardPileView.convert(self.discardPileView.center, to: self.cardsBoardView)
                        	},
                            completion: { position in
                                // Card Views cleaning
                                self.cardViews[index].transform = .identity
                                //TODO: Replacing matched cards at dealButton
								self.cardViews[index].center = self.dealButton.convert(self.dealButton.center, to: self.cardsBoardView)
                                numberOfCardsHighlighted += 1.0
                                if numberOfCardsHighlighted == 3.0 {
                                    self.game.score += 1
                                    self.dealThreeCards()
                                    // Updates the score
                                    Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { _ in
                                        self.scoreLabel.text = "\(self.game.score) Sets"
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.4,
                                            delay: 0,
                                            options: [],
                                            animations: {
                                                // Score Label gets bigger
                                                self.scoreLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                                                // Discard Pile View flashes
                                                self.discardPileView.customBackgroundColor = #colorLiteral(red: 0.9803072989, green: 1, blue: 0.2777173589, alpha: 1)
                                        	},
                                            completion: { position in
                                                // Score Label shrinks
                                                UIViewPropertyAnimator.runningPropertyAnimator(
                                                    withDuration: 0.3,
                                                    delay: 0,
                                                    options: [],
                                                    animations: {
                                                        self.scoreLabel.transform = .identity
                                                        Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false, block: { _ in
                                                        	self.discardPileView.customBackgroundColor = #colorLiteral(red: 1, green: 0.9647058824, blue: 0, alpha: 1)
                                                        })
                                                	}
                                                )
                                        	}
                                        )
                                    })
                                }
                        	}
                        )
                    })
                }
            }
        }
    }

}

//MARK: - Helper Functions

extension ViewController {
    func getCardFromCardView(_ cardView: CardView) -> Card {
        return game.displayedCards[cardViews.firstIndex(of: cardView)!]
    }

    func drawCardView(_ cardView: CardView) {
        // Sets the card design to be drawn
        cardView.shapeStyle = getCardFromCardView(cardView).shapeStyle.rawValue
        cardView.shapeColorStyle = getCardFromCardView(cardView).shapeColorStyle.rawValue
        cardView.shapeFillingStyle = getCardFromCardView(cardView).shapeFillingStyle.rawValue
        cardView.numberOfShapes = getCardFromCardView(cardView).numberOfShapes.rawValue
    }

    func indexOfSelectedCard(fromCardView cardView: CardView) -> Double {
		return Double(game.selectedCards.index(of: getCardFromCardView(cardView))!)
    }

}

//MARK: - Helper Standard Data Structures Extensions

