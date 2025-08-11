//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    var viewModel = MapViewModel()
    
    private var restaurants: [Restaurant] = []
    
    private let mapView = MKMapView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurants.append(contentsOf: RestaurantList.restaurantArray)
        dump(restaurants)
        
        setupUI()
        setupMapView()
        addAnnotation()
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "식당 지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        
        for i in restaurants {
            let foodCoordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            let region = MKCoordinateRegion(center: foodCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func addAnnotation() {
        for i in restaurants {
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotation.title = i.name
            annotation.subtitle = i.phoneNumber
            mapView.addAnnotation(annotation)
        }
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: foodCategory.korean.rawValue, style: .default) { _ in
            print("한식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.korean.rawValue)
            dump(self.restaurants)
        }
        
        let alert2Action = UIAlertAction(title: foodCategory.cafe.rawValue, style: .default) { _ in
            print("카페가 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.cafe.rawValue)
            dump(self.restaurants)
        }
        
        let alert3Action = UIAlertAction(title: foodCategory.chinease.rawValue, style: .default) { _ in
            print("중식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.chinease.rawValue)
            dump(self.restaurants)
        }
        
        let alert4Action = UIAlertAction(title: foodCategory.snack.rawValue, style: .default) { _ in
            print("분식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.snack.rawValue)
            dump(self.restaurants)
        }
        
        let alert5Action = UIAlertAction(title: foodCategory.japanese.rawValue, style: .default) { _ in
            print("일식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.japanese.rawValue)
            dump(self.restaurants)
        }
        
        let alert6Action = UIAlertAction(title: foodCategory.lightWestern.rawValue, style: .default) { _ in
            print("경양식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.lightWestern.rawValue)
            dump(self.restaurants)
        }
        
        let alert7Action = UIAlertAction(title: foodCategory.western.rawValue, style: .default) { _ in
            print("양식이 선택되었습니다.")
            
            self.filteringAnnotation(category: foodCategory.western.rawValue)
            dump(self.restaurants)
        }
        
        let alert8Action = UIAlertAction(title: "전체보기", style: .default) { _ in
            print("전체보기가 선택되었습니다.")
            
            self.restaurants.removeAll()
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            for i in RestaurantList.restaurantArray {
                self.restaurants.append(i)
            }
            
            dump(self.restaurants)
            
            for i in self.restaurants {
                
                let foodCoordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
                let region = MKCoordinateRegion(center: foodCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                let annotation = MKPointAnnotation()
                
                self.mapView.setRegion(region, animated: true)
                
                annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
                annotation.title = i.name
                annotation.subtitle = i.phoneNumber
                self.mapView.addAnnotation(annotation)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(alert4Action)
        alertController.addAction(alert5Action)
        alertController.addAction(alert6Action)
        alertController.addAction(alert7Action)
        alertController.addAction(alert8Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
    
    private func filteringAnnotation(category: String) {
        self.restaurants.removeAll()
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for i in RestaurantList.restaurantArray {
            if i.category == category {
                self.restaurants.append(i)
            }
        }
        
        for i in self.restaurants {
            let foodCoordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            let region = MKCoordinateRegion(center: foodCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            let annotation = MKPointAnnotation()
            
            self.mapView.setRegion(region, animated: true)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            annotation.title = i.name
            annotation.subtitle = i.phoneNumber
            self.mapView.addAnnotation(annotation)
        }
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}

