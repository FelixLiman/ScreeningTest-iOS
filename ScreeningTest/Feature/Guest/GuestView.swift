//
//  GuestView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class GuestView: UIView {
    
    let guestCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(guestCollectionView)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        guestCollectionView.style {
            $0.register(GuestCollectionCell.self, forCellWithReuseIdentifier: GuestCollectionCell.identifier)
            $0.backgroundColor = .clear
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 16
            $0.setCollectionViewLayout(layout, animated: true)
            $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    private func setupConstraints() {
        guestCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
}
