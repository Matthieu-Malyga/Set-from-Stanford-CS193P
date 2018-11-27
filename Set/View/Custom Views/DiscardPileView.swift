//
//  DiscardPileView.swift
//  Set
//
//  Created by malygam on 21/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import UIKit

class DiscardPileView: UIView {

    var customBackgroundColor = #colorLiteral(red: 1, green: 0.9647058824, blue: 0, alpha: 1) { didSet { setNeedsDisplay(); setNeedsLayout() } }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
		let roundedSquare = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: bounds.size), cornerRadius: cornerRadius)
        customBackgroundColor.setFill()
        roundedSquare.fill()
    }

}

extension DiscardPileView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.width * SizeRatio.cornerRadiusToBoundsHeight
    }
}
