//
//  CurrentTripViewController.swift
//  Platripus
//
//  Created by Thien Tran on 6/7/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CurrentTripViewController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateToButton: UIButton!
    @IBOutlet weak var currLocButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var navButtonShadow: UIView!
    @IBOutlet weak var currLocButtonShadow: UIView!
    @IBOutlet weak var locationLabelShadow: UIView!
    var locationManager: CLLocationManager!


    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // setup location label
        locationLabel.layer.cornerRadius = 8.0;
        locationLabel.clipsToBounds = true;
        locationLabel.text = "Current Location: Honolulu";
        locationLabel.textColor = UIColor.blackColor();
        /** Shadow */
        locationLabelShadow.layer.cornerRadius = 8.0;
        locationLabelShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        locationLabelShadow.layer.shadowOpacity = 0.6;
        locationLabelShadow.layer.shadowOffset = CGSize.zero;
        locationLabelShadow.layer.shadowRadius = 4.0;
        
        currLocButton.layer.cornerRadius = currLocButton.frame.size.width/2.0;
        currLocButton.clipsToBounds = true;
        currLocButton.addTarget(self, action: "seekToCurrentLocation", forControlEvents: .TouchUpInside);
        /** Shadow */
        currLocButtonShadow.layer.cornerRadius = currLocButtonShadow.frame.size.width/2.0;
        currLocButtonShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        currLocButtonShadow.layer.shadowOpacity = 0.6;
        currLocButtonShadow.layer.shadowOffset = CGSize.zero;
        currLocButtonShadow.layer.shadowRadius = 3.0;
        
        // setup map buttons
        navigateToButton.layer.cornerRadius = navigateToButton.frame.size.width/2.0;
        navigateToButton.clipsToBounds = true;
        navigateToButton.addTarget(self, action: "navigateTo", forControlEvents: .TouchUpInside);
        
        /** Shadow */
        navButtonShadow.layer.cornerRadius = navButtonShadow.frame.size.width/2.0;
        navButtonShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        navButtonShadow.layer.shadowOpacity = 0.6;
        navButtonShadow.layer.shadowOffset = CGSize.zero;
        navButtonShadow.layer.shadowRadius = 3.0;
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // show place on map
        let place = TravelPlaces(title: "King David Kalakaua",
            locationName: "Waikiki Gateway Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        mapView.addAnnotation(place)
        
        // request for map authorization
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            CLLocationManager().requestWhenInUseAuthorization();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func seekToCurrentLocation() {
        NSLog("asdf");
    }
    
    func navigateTo() {
        NSLog("navigation");
    }

}
