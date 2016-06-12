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

class CurrentTripViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateToButton: UIButton!
    @IBOutlet weak var currLocButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var navButtonShadow: UIView!
    @IBOutlet weak var currLocButtonShadow: UIView!
    @IBOutlet weak var locationLabelShadow: UIView!
    @IBOutlet weak var detailView: UIView!

    var locationManager: CLLocationManager!

    var locationTuples: [(textField: UITextField!, mapItem: MKMapItem?)]!
    
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
        navButtonShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        navButtonShadow.layer.shadowOpacity = 0.6;
        navButtonShadow.layer.shadowOffset = CGSize.zero;
        navButtonShadow.layer.shadowRadius = 3.0;
        
        // setup detailView
        detailView.layer.shadowColor = UIColor.blackColor().CGColor;
        detailView.layer.shadowOpacity = 0.6;
        detailView.layer.shadowOffset = CGSize.zero;
        detailView.layer.shadowRadius = 4.0;
        
        // prepare tap gesture recognizer to close the detailView
        let tgr = UITapGestureRecognizer(target: self, action: "bringDownDetailView")
        mapView.addGestureRecognizer(tgr)
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // set tuples for map info
//        locationTuples = [(sourceField: nil), (destinationField1: nil), (destinationField2: nil)]
        
        // show place on map
        let place = TravelPlaces(title: "King David Kalakaua",
            locationName: "Waikiki Gateway Park",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        mapView.addAnnotation(place)
        
        // request for map authorization
        self.startStandardUpdates();
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
        locationManager.requestLocation();

        NSLog("asdf");
    }
    
    func navigateTo() {
        NSLog("navigation");
    }
    
    // view helper methods
    
    func bringUpDetailView() {
        let newHeight = self.view.frame.size.height * 0.6
        if (self.detailView.frame.size.height < newHeight) {
            UIView.animateWithDuration(0.2) {
                self.detailView.frame = CGRectMake(0, self.view.frame.size.height - newHeight, self.view.frame.size.width, newHeight)
            }
        }
    }
    
    func bringDownDetailView() {
        let newHeight = 62 as CGFloat
        if (self.detailView.frame.size.height > newHeight) {
            UIView.animateWithDuration(0.2) {
                self.detailView.frame = CGRectMake(0, self.view.frame.size.height - newHeight, self.view.frame.size.width, newHeight)
            }
        }
    }
    
    // location methods
    
    func startStandardUpdates() {
    // Create the location manager if this object does not
    // already have one.
        if (locationManager == nil) {
            locationManager = CLLocationManager();
        }
    
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
        // Set a movement threshold for new events.
        locationManager.distanceFilter = 500; // meters
    
//        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization();
//        locationManager.requestAlwaysAuthorization();
//        }
        
        locationManager.startUpdatingLocation();
    }
    
    func formatAddressFromPlacemark(placemark: CLPlacemark) -> String {
        return (placemark.addressDictionary!["FormattedAddressLines"] as!
            [String]).joinWithSeparator(", ")
    }
    
    // CLLocationmanager delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(locations.last!,
            completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?) -> Void in
                if let placemarks = placemarks {
                    let placemark = placemarks[0]
                    self.locationLabel.text = self.formatAddressFromPlacemark(placemark)
                    self.locationLabel.textColor = UIColor.blackColor()
                    self.locationManager.stopUpdatingLocation()
                }
        })
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("error: %@", error);
    }

}
