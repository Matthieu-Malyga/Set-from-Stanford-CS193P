//
//  ControlButton.swift
//  Set
//
//  Created by malygam on 08/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import UIKit

class DealButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadius
    }

}

extension DealButton {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.width * SizeRatio.cornerRadiusToBoundsHeight
    }
}
