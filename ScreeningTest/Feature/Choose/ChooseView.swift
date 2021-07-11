//
//  ChooseView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class ChooseView: UIView {
    
    let nameTitleLbl = UILabel()
    let nameLbl = UILabel()
    
    let eventBtn = UIButton()
    let guestBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(nameTitleLbl, nameLbl, eventBtn, guestBtn)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameTitleLbl.style {
            $0.tintColor = .systemPurple
            $0.text = "Nama :"
        }
        
        nameLbl.style {
            $0.tintColor = .systemPurple
        }
        
        [eventBtn, guestBtn].style {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemPurple
            $0.setLayer(cornerRadius: 8)
        }
        
        eventBtn.style {
            $0.setTitle("Pilih Event", for: .normal)
        }
        
        guestBtn.style {
            $0.setTitle("Pilih Guest", for: .normal)
        }
    }
    
    private func setupConstraints() {
        nameTitleLbl.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(32)
            make.trailing.equalTo(self.snp.centerX).offset(-8)
            make.bottom.equalTo(self.snp.centerY).offset(-32)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(8)
            make.trailing.equalTo(self).offset(-32)
            make.bottom.equalTo(nameTitleLbl)
        }
        
        eventBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).offset(16)
            make.leading.equalTo(self).offset(32)
            make.trailing.equalTo(self).offset(-32)
        }
        
        guestBtn.snp.makeConstraints { make in
            make.top.equalTo(eventBtn.snp.bottom).offset(16)
            make.leading.trailing.equalTo(eventBtn)
        }
    }
    
}
