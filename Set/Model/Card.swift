//
//  Card.swift
//  Set
//
//  Created by malygam on 06/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import Foundation

struct Card {

    //MARK: - Properties

    let identifier: Int
    let shapeStyle: ShapeStyle
    let shapeColorStyle: ShapeColorStyle
    let shapeFillingStyle: ShapeFillingStyle
    let numberOfShapes: NumberOfShapes

    enum ShapeStyle: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }

    enum ShapeColorStyle: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }

    enum ShapeFillingStyle: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }

    enum NumberOfShapes: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }

    //MARK: - Functions

}

//MARK: - Extensions

extension Card: Hashable {
    var hashValue: Int { return identifier }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return "\(identifier) : \(shapeStyle) | \(shapeColorStyle) | \(shapeFillingStyle) | \(numberOfShapes)"
    }
}
