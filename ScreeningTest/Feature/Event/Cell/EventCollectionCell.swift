//
//  EventCollectionCell.swift
//  ScreeningTest
//
//  Created by Felix Liman on 12/07/21.
//

import UIKit

final class EventCollectionCell: UICollectionViewCell {
    
    private let eventImg = UIImageView()
    private let nameLbl = UILabel()
    
    static var identifier = "eventCollectionCell"
    
    var model: EventModel? {
        didSet {
            nameLbl.text = model?.name
            eventImg.image = UIImage(named: model?.image ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(eventImg, nameLbl)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        eventImg.style {
            $0.contentMode = .scaleAspectFill
        }
        
        nameLbl.style {
            $0.backgroundColor = .white
        }
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        eventImg.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
}

