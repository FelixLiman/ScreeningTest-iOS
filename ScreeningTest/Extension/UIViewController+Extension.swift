//
//  UIViewController+Extension.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

extension UIViewController {
    
    func presentAlert(message: AlertMessageType) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        let titleString = NSAttributedString(string: "Uh Oh.", attributes: titleAttributes)
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let messageString = NSAttributedString(string: message.rawValue.message, attributes: messageAttributes)
        
        actionSheet.setValue(titleString, forKey: "attributedTitle")
        actionSheet.setValue(messageString, forKey: "attributedMessage")
        
        let action: UIAlertAction = UIAlertAction(title: message.rawValue.action, style: .default, handler: nil)
        
        action.setValue(UIColor.systemPurple, forKey: "titleTextColor")
        actionSheet.addAction(action)
        present(actionSheet, animated: true, completion: nil)
    }
}
