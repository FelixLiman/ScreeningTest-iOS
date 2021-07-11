//
//  ChooseViewController.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa

final class ChooseViewController: UIViewController {
    
    lazy var root = ChooseView()
    
    private var disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        setButton()
    }
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        root.nameLbl.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        root.eventBtn.rx.tap.bind { [self] in
            pushToEventViewController { eventName in
                root.eventBtn.setTitle(eventName, for: .normal)
            }
        }.disposed(by: disposable)
        
        root.guestBtn.rx.tap.bind { [self] in
            pushToGuestViewController { eventName in
                root.guestBtn.setTitle(eventName, for: .normal)
            }
        }.disposed(by: disposable)
    }
    
    private func pushToEventViewController(_ callback: @escaping ((String)->Void)){
        let vc = EventViewController()
        vc.callback = callback
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushToGuestViewController(_ callback: @escaping ((String)->Void)){
        let vc = GuestViewController()
        vc.callback = callback
        navigationController?.pushViewController(vc, animated: true)
    }
}
