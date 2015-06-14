//
//  MapViewController.swift
//  GambleKeeper
//
//  Created by 三浦　和真 on 2015/06/14.
//  Copyright (c) 2015年 三浦　和真. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var longpressGesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        var centerCoodinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        var centerPosition = MKCoordinateRegionMake(centerCoodinate, span)
        self.mapView.setRegion(centerPosition, animated: true)
        
        self.longpressGesture.addTarget(self, action: "longPressed:")
        self.mapView.addGestureRecognizer(self.longpressGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func longPressed(sender : UILongPressGestureRecognizer) {
        
        if sender.state != .Began {
            return
        }
        
        var location = sender.locationInView(self.mapView)
        var mapPoint : CLLocationCoordinate2D = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        var theRoppongiAnnotation = MKPointAnnotation()
        theRoppongiAnnotation.coordinate = mapPoint
        theRoppongiAnnotation.title = "ピンおいたぜぇ〜？"
        theRoppongiAnnotation.subtitle = "ワイルドだろぅ〜？"
        self.mapView.addAnnotation(theRoppongiAnnotation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
