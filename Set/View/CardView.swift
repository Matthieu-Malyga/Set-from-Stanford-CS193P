//
//  CardView.swift
//  Set
//
//  Created by malygam on 13/11/2018.
//  Copyright © 2018 Matthieu Malyga. All rights reserved.
//

import UIKit

//@IBDesignable
class CardView: UIView {

    @IBInspectable var shapeStyle: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable var shapeColorStyle: Int = 0 {
        didSet {
            switch shapeColorStyle {
            case 1: color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            case 2: color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            case 3: color = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            default: break
            }
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    @IBInspectable var shapeFillingStyle: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable var numberOfShapes: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isSelected = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isMatched = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var color = UIColor()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {

        let roundedSquare = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: bounds.size), cornerRadius: cornerRadius)
        if isMatched {
			#colorLiteral(red: 0.9985794425, green: 0.9453933835, blue: 0, alpha: 1).setFill()
        } else {
        	#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).setFill()
        }
        roundedSquare.fill()

        let roundedBorder = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: bounds.size).insetBy(dx: bounds.width*0.01, dy: bounds.height*0.01), cornerRadius: cornerRadius)
        roundedBorder.lineWidth = bounds.height*0.03

        if isSelected {
            #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).setStroke()
        } else {
			#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).setStroke()
        }
        roundedBorder.stroke()

        switch shapeStyle {
        case 1:
            switch numberOfShapes {
            case 1:
                switch shapeFillingStyle {
                case 1: StyleKit.drawSquare(frame: bounds, color)
                case 2: StyleKit.drawSquare(frame: bounds, color, fill: true)
                case 3: StyleKit.drawStripedSquare(frame: bounds, color)
                default: break
                }
            case 2:
                switch shapeFillingStyle {
                case 1: StyleKit.drawTwoSquares(frame: bounds, color)
                case 2: StyleKit.drawTwoSquares(frame: bounds, color, fill: true)
                case 3: StyleKit.drawTwoStripedSquares(frame: bounds, color)
                default: break
                }
            case 3:
                switch shapeFillingStyle {
                case 1: StyleKit.drawThreeSquares(frame: bounds, color)
                case 2: StyleKit.drawThreeSquares(frame: bounds, color, fill: true)
                case 3: StyleKit.drawThreeStripedSquares(frame: bounds, color)
                default: break
                }
            default: break
            }
        case 2:
            switch numberOfShapes {
            case 1:
                switch shapeFillingStyle {
                case 1: StyleKit.drawCircle(frame: bounds, color)
                case 2: StyleKit.drawCircle(frame: bounds, color, fill: true)
                case 3: StyleKit.drawStripedCircle(frame: bounds, color)
                default: break
                }
            case 2:
                switch shapeFillingStyle {
                case 1: StyleKit.drawTwoCircles(frame: bounds, color)
                case 2: StyleKit.drawTwoCircles(frame: bounds, color, fill: true)
                case 3: StyleKit.drawTwoStripedCircles(frame: bounds, color)
                default: break
                }
            case 3:
                switch shapeFillingStyle {
                case 1: StyleKit.drawThreeCircles(frame: bounds, color)
                case 2: StyleKit.drawThreeCircles(frame: bounds, color, fill: true)
                case 3: StyleKit.drawThreeStripedCircles(frame: bounds, color)
                default: break
                }
            default: break
            }
        case 3:
            switch numberOfShapes {
            case 1:
                switch shapeFillingStyle {
                case 1: StyleKit.drawTriangle(frame: bounds, color)
                case 2: StyleKit.drawTriangle(frame: bounds, color, fill: true)
                case 3: StyleKit.drawStripedTriangle(frame: bounds, color)
                default: break
                }
            case 2:
                switch shapeFillingStyle {
                case 1: StyleKit.drawTwoTriangles(frame: bounds, color)
                case 2: StyleKit.drawTwoTriangles(frame: bounds, color, fill: true)
                case 3: StyleKit.drawTwoStripedTriangles(frame: bounds, color)
                default: break
                }
            case 3:
                switch shapeFillingStyle {
                case 1: StyleKit.drawThreeTriangles(frame: bounds, color)
                case 2: StyleKit.drawThreeTriangles(frame: bounds, color, fill: true)
                case 3: StyleKit.drawThreeStripedTriangles(frame: bounds, color)
                default: break
                }
            default: break
            }
        default: break
        }
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}
