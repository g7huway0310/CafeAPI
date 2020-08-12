//
//  DetailViewController.swift
//  CafeMap
//
//  Created by guowei on 2020/8/12.
//  Copyright © 2020 guowei. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude=0.0
    
    var longitude=0.0
    
    var cafeData:CafeInfo?
    
    @IBOutlet weak var cafeName: UILabel!
    
    @IBOutlet weak var cafeAddress: UILabel!
    
    @IBOutlet weak var openTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let cafeData=cafeData{
            
            latitude=Double(cafeData.latitude)!
            longitude=Double(cafeData.longitude)!
            
            
            cafeName.text=cafeData.name
            cafeAddress.text=cafeData.address
            openTime.text="\(cafeData.open_time)"
            
        }
        
        settingcafeAnnotation()
        
        print(latitude)
        print(longitude)
        //設定目標
        
    }
    @IBAction func navv(_ sender: Any) {
        map()
    }
    
    
    func settingcafeAnnotation() {
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 設置大頭針標題
        studioAnnotation.title = cafeData?.name
        // 設置大頭針副標題，需點選才能看見
        studioAnnotation.subtitle = cafeData?.address
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        // 更改當前可見區域，並且根據指定的坐標和距離值創建新的MKCoordinateRegion。
        mapView.setRegion(MKCoordinateRegion(center: studioAnnotation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100), animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
    
    func map(){
        
        if let cafeData=cafeData{
                   
                   latitude=Double(cafeData.latitude)!
                   longitude=Double(cafeData.longitude)!
                   
                   cafeName.text=cafeData.name
                   cafeAddress.text=cafeData.address
                   openTime.text="\(cafeData.open_time)"
                   
               }
        
        print(latitude)
        print(longitude)
        
        let targetLocation=CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //初始化使用MKPlacemark
        let targetPlacemark=MKPlacemark(coordinate: targetLocation)
        
        let targetItem=MKMapItem(placemark: targetPlacemark)
        
        let userMapItem=MKMapItem.forCurrentLocation()
        
        print(userMapItem)
        let routes=[userMapItem,targetItem]
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
}
