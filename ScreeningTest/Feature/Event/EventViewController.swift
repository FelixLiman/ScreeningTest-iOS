//
//  EventViewController.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

final class EventViewController: UIViewController {
    
    lazy var root = EventView()
    
    private var eventData: [EventModel]?
    
    var callback: ((String) -> Void) = { _ in }
    
    var disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = root
        
        getData()
        setButton()
        setMapKit()
        root.eventTableView.delegate = self
        root.eventTableView.dataSource = self
        root.eventCollectionView.delegate = self
        root.eventCollectionView.dataSource = self
    }
    
    private func getData() {
        guard let data = readLocalJSONFile(forName: "event") else { return }
        eventData = parse(jsonData: data)
    }
    
    private func setButton() {
        root.backBtn.rx.tap.bind { _ in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposable)
        
        root.addBtn.rx.tap.bind { _ in
            self.toggleMapView()
        }.disposed(by: disposable)
    }
    
    private func setMapKit() {
        guard let eventData = eventData else { return }
        for event in eventData {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(event.lat),
                longitude: CLLocationDegrees(event.lng))
            annotation.title = event.name
            root.eventMapView.addAnnotation(annotation)
        }
        
        guard let model = eventData.get(0) else { return }
        root.eventMapView.centerToLocation(
            CLLocation(latitude: CLLocationDegrees(model.lat),
                       longitude: CLLocationDegrees(model.lng)))
        guard let annotation = root.eventMapView.annotations.first(where: { $0.title == model.name }) else { return }
        root.eventMapView.selectAnnotation(annotation, animated: true)
    }
    
    private func toggleMapView() {
        if root.eventTableView.isHidden {
            root.eventTableView.isHidden = false
            root.mapView.isHidden = true
        } else {
            root.eventTableView.isHidden = true
            root.mapView.isHidden = false
        }
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

extension EventViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eventData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.identifier, for: indexPath) as! EventCollectionCell
        cell.model = eventData?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: 200)
        return size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = root.eventCollectionView.indexPathsForVisibleItems.first,
              let model = eventData?.get(indexPath.item)
        else { return }
        
        root.eventMapView.centerToLocation(
            CLLocation(latitude: CLLocationDegrees(model.lat),
                       longitude: CLLocationDegrees(model.lng)))
        guard let annotation = root.eventMapView.annotations.first(where: { $0.title == model.name }) else { return }
        root.eventMapView.selectAnnotation(annotation, animated: true)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
