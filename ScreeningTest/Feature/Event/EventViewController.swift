//
//  EventViewController.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa

final class EventViewController: UIViewController {
    
    lazy var root = EventView()
    
    private var eventData: [EventModel]?
    
    var callback: ((String) -> Void) = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        getData()
        root.eventTableView.delegate = self
        root.eventTableView.dataSource = self
    }
    
    private func getData() {
        guard let data = readLocalJSONFile(forName: "event") else { return }
        eventData = parse(jsonData: data)
    }
}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableCell.identifier, for: indexPath) as! EventTableCell
        cell.model = eventData?[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = eventData?[indexPath.item].name else { return }
        callback(name)
        navigationController?.popViewController(animated: true)
    }
    
}
