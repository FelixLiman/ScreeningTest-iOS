//
//  HomeView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class HomeView: UIView {
    
    let nameTF = UITextField()
    let nextBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(nameTF, nextBtn)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameTF.style {
            $0.borderStyle = .roundedRect
            $0.tintColor = .systemPurple
            $0.placeholder = "Masukkan nama"
        }
        
        nextBtn.style {
            $0.setTitle("Next", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemPurple
            $0.setLayer(cornerRadius: 8)
        }
    }
    
    private func setupConstraints() {
        nameTF.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(32)
            make.trailing.equalTo(self).offset(-32)
            make.bottom.equalTo(self.snp.centerY).offset(-16)
        }
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).offset(16)
            make.leading.trailing.equalTo(nameTF)
        }
    }
    
}
