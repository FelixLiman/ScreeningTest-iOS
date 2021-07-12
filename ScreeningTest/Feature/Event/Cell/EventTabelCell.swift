//
//  EventTabelCell.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class EventTableCell: UITableViewCell {
    
    private let eventImg = UIImageView()
    private let nameLbl = UILabel()
    private let dateLbl = UILabel()
    
    static var identifier = "eventTableCell"
    
    var model: EventModel? {
        didSet {
            eventImg.image = UIImage(named: model?.image ?? "")
            nameLbl.text = model?.name
            dateLbl.text = model?.date
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubviews(eventImg, nameLbl, dateLbl)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        eventImg.style {
            $0.contentMode = .scaleAspectFill
            $0.setLayer(cornerRadius: 8)
            $0.clipsToBounds = true
        }
        
        nameLbl.style {
            $0.numberOfLines = 0
        }
        
        dateLbl.style {
            $0.numberOfLines = 0
        }
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        eventImg.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
            make.size.equalTo(120)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(eventImg)
            make.leading.equalTo(eventImg.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        dateLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(16)
            make.leading.equalTo(eventImg.snp.trailing).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
}
