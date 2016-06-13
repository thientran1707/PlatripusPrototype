//
//  MapViewVC.swift
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/11/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import Foundation
import MapKit

extension CurrentTripViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? TravelPlaces {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.pinTintColor = UIColor.blueColor();
//                let tgr = UITapGestureRecognizer(target: self, action: "bringUpDetailView");
//                view.addGestureRecognizer(tgr);
//                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
//        let pinView = view as! MKPinAnnotationView
//        if (pinView.pinTintColor.isEqual(UIColor.grayColor())) { // not clicked yet
//            pinView.pinTintColor = UIColor.blueColor();
//        } else {
//            pinView.pinTintColor = UIColor.grayColor();
//        }
        self.destinationAnnotation = view.annotation!
        showDetail(view.annotation!);
    }
        
}