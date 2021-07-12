//
//  HomeView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class HomeView: UIView {
    
    let backgroundView = UIImageView()
    let titleLbl = UILabel()
    let descriptionLbl = UILabel()
    
    let profileImg = UIImageView()
    
    let nameTF = UITextField()
    let nameImg = UIImageView()
    
    let nextBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(backgroundView, titleLbl, descriptionLbl, profileImg, nameImg, nameTF, nameImg, nextBtn)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundView.style {
            $0.image = UIImage(named: "backgroundValidate")
            $0.contentMode = .scaleAspectFill
        }
        
        titleLbl.style {
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.text = "Selamat Datang!"
        }
        
        descriptionLbl.style {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.textColor = .white
            $0.text = "Sertakan gambar profile Anda\nuntuk melengkapi profil."
        }
        
        profileImg.style {
            $0.image = UIImage(named: "addPhoto")
            $0.contentMode = .scaleAspectFit
        }
        
        nameTF.style {
            $0.tintColor = .white
            $0.textColor = .white
            $0.text = "Masukkan nama"
            $0.backgroundColor = .clear
            
        }
        
        nameImg.style {
            $0.backgroundColor = .white
//            $0.image = UIImage(named: "nameTF")
//            $0.contentMode = .scaleToFill
        }
        
        nextBtn.style {
            $0.setTitle("Next", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .clear
            $0.titleLabel?.textAlignment = .center
            $0.setLayer(cornerRadius: 8, borderWidth: 2, borderColor: .white)
        }
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(48)
            make.leading.equalTo(backgroundView).offset(32)
            make.trailing.equalTo(backgroundView).offset(-32)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(48)
            make.leading.equalTo(titleLbl)
            make.trailing.equalTo(titleLbl)
        }
        
        profileImg.snp.makeConstraints { make in
            make.top.equalTo(descriptionLbl.snp.bottom).offset(48)
            make.centerX.equalTo(backgroundView)
            make.size.equalTo(120)
        }
        
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom).offset(48)
            make.leading.equalTo(titleLbl)
            make.trailing.equalTo(titleLbl)
        }
        
        nameImg.snp.makeConstraints { make in
            make.bottom.equalTo(nameTF).offset(8)
            make.leading.trailing.equalTo(titleLbl)
            make.height.equalTo(1)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.leading.equalTo(titleLbl)
            make.trailing.equalTo(titleLbl)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-64)
        }
        
        nextBtn.titleLabel?.snp.makeConstraints { make in
            make.leading.equalTo(nextBtn).offset(16)
            make.trailing.equalTo(nextBtn).offset(-16)
            make.top.equalTo(nextBtn).offset(16)
            make.bottom.equalTo(nextBtn).offset(-16)
        }
    }
    
}
