//
//  UIViewController+Extension.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        
        actionSheet.setValue(titleString, forKey: "attributedTitle")
        actionSheet.setValue(messageString, forKey: "attributedMessage")
        
        for action in actions {
            action.setValue(UIColor.systemPurple, forKey: "titleTextColor")
            actionSheet.addAction(action)
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
}
