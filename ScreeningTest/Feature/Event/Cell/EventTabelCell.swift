//
//  EventTabelCell.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class EventTableCell: UITableViewCell {
    
    private let containerView = UIView()
    private let eventImg = UIImageView()
    private let nameLbl = UILabel()
    private let dateLbl = UILabel()
    private let descriptionLbl = UILabel()
    
    static var identifier = "eventTableCell"
    
    var model: EventModel? {
        didSet {
            eventImg.image = UIImage(named: model?.image ?? "")
            nameLbl.text = model?.name
            dateLbl.text = model?.date
            descriptionLbl.text = model?.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubviews(eventImg, nameLbl, dateLbl, descriptionLbl)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        containerView.style {
            $0.backgroundColor = .white
            $0.setLayer(cornerRadius: 4)
        }
        
        eventImg.style {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        nameLbl.style {
            $0.font = UIFont.boldSystemFont(ofSize: 17)
            $0.numberOfLines = 0
        }
        
        dateLbl.style {
            $0.numberOfLines = 0
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        
        descriptionLbl.style {
            $0.numberOfLines = 4
            $0.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.leading.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
            make.bottom.equalTo(contentView).offset(-4)
        }
        
        eventImg.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView)
            make.width.equalTo(120)
            make.height.equalTo(180)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(eventImg).offset(8)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(eventImg.snp.leading).offset(-16)
        }
        
        dateLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(eventImg.snp.leading).offset(-16)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(dateLbl.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(eventImg.snp.leading).offset(-16)
            make.bottom.equalTo(containerView).offset(-16)
        }
    }
    
}
