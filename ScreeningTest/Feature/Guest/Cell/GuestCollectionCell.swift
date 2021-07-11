//
//  GuestCollectionCell.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class GuestCollectionCell: UICollectionViewCell {
    
    private let guestImg = UIImageView()
    private let nameLbl = UILabel()
    
    static var identifier = "guestCollectionCell"
    
    var model: GuestModel? {
        didSet {
            nameLbl.text = model?.name
            let imageName = "guest_\(model?.id ?? 0 % 5)"
            guestImg.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(guestImg, nameLbl)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        guestImg.style {
            $0.contentMode = .scaleAspectFill
            $0.setLayer(cornerRadius: 8)
            $0.clipsToBounds = true
        }
        
        nameLbl.style {
            $0.backgroundColor = .white
            $0.textAlignment = .center
        }
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        guestImg.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
}

