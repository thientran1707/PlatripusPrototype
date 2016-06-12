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
    @IBOutlet weak var locationLabelShadow: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // setup location label
        locationLabel.layer.cornerRadius = 8.0
        locationLabel.clipsToBounds = true
        locationLabel.text = "Honolulu Visitor Center"
        /** Shadow */
        locationLabelShadow.layer.cornerRadius = 8.0;
        locationLabelShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        locationLabelShadow.layer.shadowOpacity = 0.6;
        locationLabelShadow.layer.shadowOffset = CGSize.zero;
        locationLabelShadow.layer.shadowRadius = 4.0;
        
        // setup map buttons
        navigateToButton.layer.cornerRadius = navigateToButton.frame.size.width/2.0
        navigateToButton.clipsToBounds = true
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
