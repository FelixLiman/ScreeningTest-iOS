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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        getData()
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
                }
            case .failure(let error):
                print(error)
                let actionSheet = UIAlertController(title: nil, message: "Something went wrong. Lets try again.", preferredStyle: .alert)
                
                let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
                let titleString = NSAttributedString(string: "Uh oh.", attributes: titleAttributes)
                
                actionSheet.setValue(titleString, forKey: "attributedTitle")
                
                let action = UIAlertAction(title: "Ok", style: .default) { action in
                    self.getData()
                }
                action.setValue(UIColor.systemPurple, forKey: "titleTextColor")
                
                actionSheet.addAction(action)
                
                self.present(actionSheet, animated: true, completion: nil)
            }
        }
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
              let birthDateSubstring = model.birthdate.split(separator: "-").last
        else { return }
        
        var alertTitle: String
        
        let birthDate: Int = Int(String(birthDateSubstring)) ?? 0
        if birthDate.isMultiple(of: 6) {
            alertTitle = "iOS"
        } else if birthDate.isMultiple(of: 2) {
            alertTitle = "Blackberry"
        } else if birthDate.isMultiple(of: 3) {
            alertTitle = "Android"
        } else {
            alertTitle = "Feature Phone"
        }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
        let titleString = NSAttributedString(string: alertTitle, attributes: titleAttributes)
        
        actionSheet.setValue(titleString, forKey: "attributedTitle")
        
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            self.callback(model.name)
            self.navigationController?.popViewController(animated: true)
        }
        action.setValue(UIColor.systemPurple, forKey: "titleTextColor")
        
        actionSheet.addAction(action)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
