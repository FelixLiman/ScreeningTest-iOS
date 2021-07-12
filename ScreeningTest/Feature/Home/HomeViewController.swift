//
//  HomeViewController.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController {
    
    lazy var root = HomeView()
    
    var disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        root.nameTF.delegate = self
        
        setNavBar()
        setButton()
    }
    
    private func setNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setButton() {
        root.nextBtn.rx.tap.bind { [self] in
            guard let name = root.nameTF.text,
                  name != ""
            else {
                presentAlert(title: "Uh oh.", message: "You have not enter your name yet.\nLets try again.", actions: [UIAlertAction(title: "Try again", style: .default, handler: nil)])
                return
            }
            let title = isPalindrome(name) ? "Is Palindrome" : "Not Palindrome"
            let message = isPalindrome(name) ? "This name is a palindrome" : "This name is not a palindrome"
            presentAlert(title: title,
                         message: message,
                         actions: [
                            UIAlertAction(title: "Go to Next Page", style: .default, handler: { _ in
                                self.pushToChooseViewController(with: name)
                            })
                         ])
        }.disposed(by: disposable)
    }
    
    private func isPalindrome(_ string: String) -> Bool {
        var cleanifiedString = string.lowercased()
        let allowedCharacters : Set<Character> = Set("abcdefghijklmnopqrstuvwxyz")
        cleanifiedString = cleanifiedString.filter({ allowedCharacters.contains($0) })
        
        return cleanifiedString == String(cleanifiedString.reversed())
    }
    
    private func pushToChooseViewController(with name: String) {
        let vc = ChooseViewController(name: name)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == .white {
            textField.text = nil
            textField.textColor = .white
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = "Masukkan nama"
            textField.textColor = .white
        }
    }
}
