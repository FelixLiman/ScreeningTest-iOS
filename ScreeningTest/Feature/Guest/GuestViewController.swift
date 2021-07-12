//
//  GuestViewController.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa

final class GuestViewController: UIViewController {
    
    lazy var root = GuestView()
    
    private var guestData: [GuestModel]?
    
    var callback: ((String) -> Void) = { _ in }
    
    var disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        root.guestCollectionView.refreshControl?.beginRefreshing()
        
        getData()
        setRefresh()
        root.guestCollectionView.delegate = self
        root.guestCollectionView.dataSource = self
    }
    
    private func getData() {
        let url = "http://www.mocky.io/v2/596dec7f0f000023032b8017"

        loadJson(fromURLString: url) { (result) in
            switch result {
            case .success(let data):
                self.guestData = parse(jsonData: data)
                DispatchQueue.main.async {
                    self.root.guestCollectionView.reloadData()
                    self.root.guestCollectionView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
                self.presentAlert(title: "Uh oh.",
                             message: "Something went wrong. Lets try again.",
                             actions: [
                                UIAlertAction(title: "Ok", style: .default) { action in
                                    self.getData()
                                    
                                }
                             ])
            }
        }
    }
    
    private func setRefresh() {
        root.guestCollectionView.refreshControl?.rx.controlEvent(.valueChanged).subscribe { _ in
            self.getData()
        }.disposed(by: disposable)

    }
    
    private func isPrime(_ number: Int) -> Bool {
        guard number >= 2 else { return false }
        guard number != 2 else { return true  }
        guard number % 2 != 0 else { return false }
        return !stride(from: 3, through: Int(sqrt(Double(number))), by: 2).contains { number % $0 == 0 }
    }
}

extension GuestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guestData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuestCollectionCell.identifier, for: indexPath) as! GuestCollectionCell
        cell.model = guestData?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 24
        let size = CGSize(width: width, height: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = guestData?[indexPath.item],
              let birthDateSubstring = model.birthdate.split(separator: "-").last,
              let birthMonthSubString = model.birthdate.split(separator: "-").get(1)
        else { return }
        
        var alertTitle: String
        
        let birthMonth = Int(String(birthMonthSubString)) ?? 0
        let alertSecondTitle = isPrime(birthMonth) ? "Month is Prime" : "Month is not Prime"
         
        let birthDate: Int = Int(String(birthDateSubstring)) ?? 0
        if birthDate.isMultiple(of: 6) {
            alertTitle = "iOS\n\(alertSecondTitle)"
        } else if birthDate.isMultiple(of: 2) {
            alertTitle = "Blackberry\n\(alertSecondTitle)"
        } else if birthDate.isMultiple(of: 3) {
            alertTitle = "Android\n\(alertSecondTitle)"
        } else {
            alertTitle = "Feature Phone\n\(alertSecondTitle)"
        }
        
        
        self.presentAlert(title: alertTitle,
                          message: "",
                          actions: [
                            UIAlertAction(title: "Ok", style: .default) { action in
                                self.callback(model.name)
                                self.navigationController?.popViewController(animated: true)
                            }
                          ])
    }
}
