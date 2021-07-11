//
//  EventView.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit

final class EventView: UIView {
    
    let eventTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews(eventTableView)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        eventTableView.style {
            $0.register(EventTableCell.self, forCellReuseIdentifier: EventTableCell.identifier)
        }
    }
    
    private func setupConstraints() {
        eventTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
    
}
