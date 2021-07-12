//
//  Array+Extension.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

extension Array {
    func get(_ index: Int) -> Element? {
        return (0 <= index && index < count) ? self[index] : nil
    }
}

extension Array where Element: UIView {
    func style(_ completion: @escaping ((Element)->Void)) {
        for item in self {
            completion(item)
        }
    }
}
