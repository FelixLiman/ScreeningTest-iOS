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
                presentAlert(message: .nameError)
                return
            }
            pushToChooseViewController(with: name)
        }.disposed(by: disposable)
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
}
