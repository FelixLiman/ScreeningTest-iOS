//
//  UIAppearance+Extension.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

extension UIAppearance {
    
    func style(_ completion: @escaping ((Self)->Void)) {
        completion(self)
    }
    
}
