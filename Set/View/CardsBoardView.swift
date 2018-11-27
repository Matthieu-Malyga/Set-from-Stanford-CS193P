//
//  CardsBoardView.swift
//  Set
//
//  Created by malygam on 16/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import UIKit

class CardsBoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var numberOfCardsToBeDisplayed = 0 {
        didSet {
            grid.cellCount = numberOfCardsToBeDisplayed
            setNeedsLayout()
        }
    }

    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(CGFloat(0.648)), frame: bounds)

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
		grid.frame = bounds
    }

}
