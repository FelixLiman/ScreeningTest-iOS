//
//  UIView+Extension.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

extension UIView {
    ///Adds a view to the end of the receiver's list of subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func setLayer(cornerRadius: CGFloat? = nil, borderWidth width: CGFloat? = nil, borderColor color: UIColor? = nil) {
        setNeedsLayout()
        layoutIfNeeded()
        if let radius = cornerRadius {
            let size = (frame.width == 0 ? frame.height : frame.width) / 2
            layer.cornerRadius = (radius == 0 ? size : radius)
        } else {
            layer.cornerRadius = 0
        }
        
        if let width = width {
            layer.borderWidth = width
        }
        if let color = color {
            layer.borderColor = color.cgColor
        }
        layer.masksToBounds = false
    }
    
    func roundCorner() {
        setNeedsLayout()
        layoutIfNeeded()
        self.layer.cornerRadius = (self.bounds.size.width / 2)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
}
    
