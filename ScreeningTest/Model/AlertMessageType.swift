//
//  AlertMessageType.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import Foundation

enum AlertMessageType: RawRepresentable {
    typealias RawValue = (message: String, action: String)
    
    case nameError
    
    init?(rawValue: (message: String, action: String)) {
        switch rawValue {
        case ("You have not enter your name yet.\nLets try again.", "Try again"):
            self = .nameError
        default:
            return nil
        }
    }
    
    var rawValue: (message: String, action: String) {
        switch self {
        case .nameError:
            return ("You have not enter your name yet.\nLets try again.", "Try again")
        }
    }
}
