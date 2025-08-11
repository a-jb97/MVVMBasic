//
//  MapViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/11/25.
//

import Foundation
import MapKit

enum foodCategory: String, CaseIterable {
    case korean = "한식"
    case cafe = "카페"
    case chinease = "중식"
    case snack = "분식"
    case japanese = "일식"
    case lightWestern = "경양식"
    case western = "양식"
}

class MapViewModel {
    var inputRestaurantList = Observable("")
    
    init() {
        print("MapViewModel init")
        
        inputRestaurantList.runAction { _ in
            
        }
    }
    
    var outputMapView = Observable("")
    
////    private func addSeoulStationAnnotation() {
//////        let annotation = MKPointAnnotation()
//////        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
//////        annotation.title = "서울역"
//////        annotation.subtitle = "대한민국 서울특별시"
//////        mapView.addAnnotation(annotation)
////        
////        for i in inputRestaurantList.value {
////            let annotation = MKPointAnnotation()
////            
////            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
////            annotation.title = i.name
////            annotation.subtitle = i.phoneNumber
////            mapView.addAnnotation(annotation)
////        }
////    }
//    
//    private func sortAnnotation(category: String) {
//        self.restaurants.removeAll()
//        self.mapView.removeAnnotations(self.mapView.annotations)
//        
//        for i in RestaurantList.restaurantArray {
//            if i.category == category {
//                self.restaurants.append(i)
//            }
//        }
//        
//        for i in inputRestaurantList.value {
//            let foodCoordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
//            let region = MKCoordinateRegion(center: foodCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
//            let annotation = MKPointAnnotation()
//            
//            self.mapView.setRegion(region, animated: true)
//            
//            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
//            annotation.title = i.name
//            annotation.subtitle = i.phoneNumber
//            self.mapView.addAnnotation(annotation)
//        }
//    }
//    
//    private func rightBarButtonAction() {
//        let alertController = UIAlertController(
//            title: "메뉴 선택",
//            message: "원하는 옵션을 선택하세요",
//            preferredStyle: .actionSheet
//        )
//        
//        let alert1Action = UIAlertAction(title: foodCategory.korean.rawValue, style: .default) { _ in
//            print("한식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.korean.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert2Action = UIAlertAction(title: foodCategory.cafe.rawValue, style: .default) { _ in
//            print("카페가 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.cafe.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert3Action = UIAlertAction(title: foodCategory.chinease.rawValue, style: .default) { _ in
//            print("중식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.chinease.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert4Action = UIAlertAction(title: foodCategory.snack.rawValue, style: .default) { _ in
//            print("분식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.snack.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert5Action = UIAlertAction(title: foodCategory.japanese.rawValue, style: .default) { _ in
//            print("일식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.japanese.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert6Action = UIAlertAction(title: foodCategory.lightWestern.rawValue, style: .default) { _ in
//            print("경양식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.lightWestern.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert7Action = UIAlertAction(title: foodCategory.western.rawValue, style: .default) { _ in
//            print("양식이 선택되었습니다.")
//            
//            self.sortAnnotation(category: foodCategory.western.rawValue)
//            dump(self.restaurants)
//        }
//        
//        let alert8Action = UIAlertAction(title: "전체보기", style: .default) { _ in
//            print("전체보기가 선택되었습니다.")
//            
//            self.restaurants.removeAll()
//            self.mapView.removeAnnotations(self.mapView.annotations)
//            
//            for i in RestaurantList.restaurantArray {
//                self.restaurants.append(i)
//            }
//            
//            dump(self.restaurants)
//            
//            for i in self.restaurants {
//                
//                let foodCoordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
//                let region = MKCoordinateRegion(center: foodCoordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
//                let annotation = MKPointAnnotation()
//                
//                self.mapView.setRegion(region, animated: true)
//                
//                annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
//                annotation.title = i.name
//                annotation.subtitle = i.phoneNumber
//                self.mapView.addAnnotation(annotation)
//                
//            }
//        }
//        
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
//            print("취소가 선택되었습니다.")
//        }
//        
//        alertController.addAction(alert1Action)
//        alertController.addAction(alert2Action)
//        alertController.addAction(alert3Action)
//        alertController.addAction(alert4Action)
//        alertController.addAction(alert5Action)
//        alertController.addAction(alert6Action)
//        alertController.addAction(alert7Action)
//        alertController.addAction(alert8Action)
//        alertController.addAction(cancelAction)
//         
//        present(alertController, animated: true, completion: nil)
//    }
}
