//
//  EventView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import MapKit

final class EventView: UIView {
    
    let headerView = UIView()
    let backBtn = UIButton()
    let titleLbl = UILabel()
    let searchBtn = UIButton()
    let addBtn = UIButton()
    let lineImg = UIImageView()
    
    let eventTableView = UITableView()
    
    let mapView = UIView()
    
    let eventCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    let eventMapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(headerView, eventTableView, mapView)
        headerView.addSubviews(backBtn, titleLbl, searchBtn, addBtn, lineImg)
        mapView.addSubviews(eventCollectionView, eventMapView)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        headerView.style {
            $0.backgroundColor = .white
        }
        
        backBtn.style {
            $0.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .systemGreen
            $0.contentMode = .scaleAspectFit
        }
        
        titleLbl.style {
            $0.textColor = .systemGreen
            $0.text = "MESSAGE FROM CODI"
        }
        
        searchBtn.style {
            $0.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .systemGreen
            $0.contentMode = .scaleAspectFit
        }
        
        addBtn.style {
            $0.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .systemGreen
            $0.contentMode = .scaleAspectFit
        }
        
        lineImg.style {
            $0.backgroundColor = .systemGreen
        }
        
        eventTableView.style {
            $0.register(EventTableCell.self, forCellReuseIdentifier: EventTableCell.identifier)
            $0.separatorStyle = .none
            $0.backgroundColor = .init(white: 0.95, alpha: 1)
        }
        
        mapView.style {
            $0.isHidden = true
        }
        
        eventCollectionView.style {
            $0.register(EventCollectionCell.self, forCellWithReuseIdentifier: EventCollectionCell.identifier)
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = .zero
            layout.scrollDirection = .horizontal
            $0.setCollectionViewLayout(layout, animated: true)
            $0.isPagingEnabled = true
            $0.backgroundColor = .white
        }
        
        eventMapView.style {
            $0.backgroundColor = .white
        }
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(headerView).offset(8)
            make.leading.equalTo(headerView).offset(16)
            make.bottom.equalTo(lineImg.snp.top).offset(-8)
            make.size.equalTo(24)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.leading.equalTo(backBtn.snp.trailing).offset(16)
            make.trailing.equalTo(searchBtn.snp.leading).offset(-16)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.top.equalTo(headerView).offset(8)
            make.trailing.equalTo(addBtn.snp.leading).offset(-12)
            make.bottom.equalTo(lineImg.snp.top).offset(-8)
            make.size.equalTo(24)
        }
        
        addBtn.snp.makeConstraints { make in
            make.top.equalTo(headerView).offset(8)
            make.trailing.equalTo(headerView).offset(-16)
            make.bottom.equalTo(lineImg.snp.top).offset(-8)
            make.size.equalTo(24)
        }
        
        lineImg.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(headerView)
            make.height.equalTo(4)
        }
        
        eventTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        eventCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mapView)
            make.height.equalTo(200)
        }
        
        eventMapView.snp.makeConstraints { make in
            make.top.equalTo(eventCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalTo(mapView)
        }
    }
    
}
