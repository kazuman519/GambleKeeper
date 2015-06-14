//
//  ViewController.swift
//  GambleKeeper
//
//  Created by 三浦　和真 on 2015/06/13.
//  Copyright (c) 2015年 三浦　和真. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var player = Player()
    
    // 位置除法
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var runningDistance : CLLocationDistance = Double(0)
    
    
    struct Player {
        var name : String
        var money : Float
        var runningDistance : Float
        
        init() {
            name = "未設定"
            money = 0
            runningDistance = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.name = "Miura"
        nameLabel.text = player.name
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkinAction(sender: AnyObject) {
        NSLog("hogehoge")
        checkinAction()
    }
    
    func checkinAction() {
        // 位置情報のアクセス許可の状況に応じて、アクセス許可の取得、位置情報取得の開始を行う
        let status = CLLocationManager.authorizationStatus()
        switch status{
        case .Restricted, .Denied:
            break
        case .NotDetermined:
            // iOS8ではアクセス許可のリクエストをする。iOS7では位置情報取得処理を開始することでアクセス許可のリクエストをする
            if locationManager.respondsToSelector("requestAlwaysAuthorization"){
                locationManager.requestAlwaysAuthorization()
            }else{
                locationManager.startUpdatingLocation()
            }
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    
    // 位置情報のアクセス許可の状況が変わったときの処理
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status{
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // 位置情報が取得できたときの処理
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if locations.count > 0{
            var location = locations.last as? CLLocation
            var distance = currentLocation?.distanceFromLocation(location)
            
            if distance != nil {
                runningDistance += (distance! + 10)
            }

            NSLog("移動距離\(runningDistance)")
            
            currentLocation = locations.last as? CLLocation
            NSLog("緯度:\(currentLocation?.coordinate.latitude) 経度:\(currentLocation?.coordinate.longitude)")
        }
        
    }
    
    func conversionToMoney(runningDistanceM: Float) -> Int {
        var money : Int
        money = Int(runningDistanceM) / 30
        return money
    }
}

