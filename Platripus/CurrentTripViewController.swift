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

class CurrentTripViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateToButton: UIButton!
    @IBOutlet weak var currLocButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var navButtonShadow: UIView!
    @IBOutlet weak var currLocButtonShadow: UIView!
    @IBOutlet weak var locationLabelShadow: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailViewLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var fullItineraryButton: UIButton!
    
    var todoTableView: UITableView!

    var locationManager: CLLocationManager!
    
    var travelPlace: TravelPlaces!

    var locationTuples: [(textField: UITextField!, mapItem: MKMapItem?)]!
    var currentLocation: CLLocation!
    var destinationAnnotation: MKAnnotation!
    
    var destinations: [String: CLLocationCoordinate2D] = [
        "Golden Gate Park": CLLocationCoordinate2D(latitude: 37.769258, longitude: -122.482658),
        "Golden Gate Bridge" : CLLocationCoordinate2D(latitude: 37.807682, longitude: -122.474910),
        "Sutro Baths" : CLLocationCoordinate2D(latitude: 37.780127, longitude: -122.513127),
        "Ocean Beach" : CLLocationCoordinate2D(latitude: 37.772597, longitude: -122.511278),
        "Cliff House" : CLLocationCoordinate2D(latitude: 37.778508, longitude: -122.514020),
    ]
    
    var currentTripDictionary: [String: String] = [
        "Golden Gate Park":"Central gathering spot for the hippie generation during the 1967. A nod to that history can be seen today in the daily gatherings at Hippie Hill. Today it is one of the top five most-visited city parks in the United States.",
        "Golden Gate Bridge" : "The iconic arches of San Francisco, California's Golden Gate Bridge are known the world over as a symbol of California and the San Francisco Bay area. From movies to postcards, the Golden Gate Bridge is an American icon.",
        "Sutro Baths" : "Large, privately owned public saltwater swimming pool complex. Built in 1896, it was located near the Cliff House, Seal Rock, and Sutro Heights Park. The facility burned down in 1967 and is now in ruins.",
        "Ocean Beach" : "3.5-mile stretch of white beach with few tourists and no highrises. It's just you and the waves and the seabirds at Ocean Beach, on the westernmost border of San Francisco. Great for strolling and flying kites.",
        "Cliff House" : "Part of the Sutro Historic Landscape District and is also the crown jewel of the largest urban national park in the United States. It has casual Bistro Restaurant on the main level and the elegant Sutro’s at the Cliff House on the lower level.",
    ]
    
    var thingsToDoDictionary: [String: [String]] = [
        "Golden Gate Park":["🏛Academy of Sciences", "🏛De Young's Museum", "🌿Conservatory of Flowers", "🌿Lloyed Lake"],
        "Golden Gate Bridge" : [],
        "Sutro Baths" : [],
        "Ocean Beach" : [],
        "Cliff House" : [],
    ]

    
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
//        navigateToButton.layer.masksToBounds = true;
        navigateToButton.enabled = false;
        navigateToButton.addTarget(self, action: "navigateTo", forControlEvents: .TouchUpInside);
        
        /** Shadow */
        navButtonShadow.layer.cornerRadius = navigateToButton.frame.size.width/2.0;
        navButtonShadow.layer.shadowColor = UIColor.blackColor().CGColor;
        navButtonShadow.layer.shadowOpacity = 0.6;
        navButtonShadow.layer.shadowOffset = CGSize.zero;
        navButtonShadow.layer.shadowRadius = 3.0;
        
        // setup full itinerary view
        fullItineraryButton.titleLabel?.lineBreakMode = .ByWordWrapping;
        fullItineraryButton.addTarget(self, action: "goToFullItinerary", forControlEvents: .TouchUpInside)
        
        // setup detailView
        detailView.frame = CGRectMake(0, 506, 320, 340)
        detailView.layer.shadowColor = UIColor.blackColor().CGColor;
        detailView.layer.shadowOpacity = 0.6;
        detailView.layer.shadowOffset = CGSize.zero;
        detailView.layer.shadowRadius = 4.0;
        
        detailScrollView.hidden = true
        
        // prepare tap gesture recognizer to close the detailView
        let tgr = UITapGestureRecognizer(target: self, action: "bringDownDetailView:")
        mapView.addGestureRecognizer(tgr)
        
        // set initial location in Block 71
        let initialLocation = CLLocation(latitude: 37.782263, longitude: -122.392143)
        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // set tuples for map info
//        locationTuples = [(sourceField: nil), (destinationField1: nil), (destinationField2: nil)]
        
        // show places on map
        for (placeName, coordinates) in self.destinations {
            let place = TravelPlaces(title: placeName,
                coordinate: coordinates)
            
            mapView.addAnnotation(place)
        }
        
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
       // NSLog("http://maps.apple.com/?saddr=%@&daddr=%@&dirflg=r");
        let mapUrl = NSURL(string: String(format: "http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f", arguments: [self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude, self.destinationAnnotation.coordinate.latitude, self.destinationAnnotation.coordinate.longitude]))
        UIApplication.sharedApplication().openURL(mapUrl!);
        
    }
    
    // view helper methods
    
    func bringUpDetailView() {
//        let newHeight = self.view.frame.size.height * 0.6
        let newY = 228 as CGFloat
        let heightMoved = self.detailView.frame.origin.y - newY;
        if (heightMoved > 0) {
            self.detailScrollView.hidden = false
            self.detailScrollView.contentSize = self.detailScrollView.frame.size
            UIView.animateWithDuration(0.2, animations: {
                self.detailView.frame = CGRectMake(0, newY, self.detailView.frame.size.width, self.detailView.frame.size.height)
                self.navigateToButton.enabled = true;
                }, completion: {
                    finished in
                    self.detailViewLabel.text = String(format: "%@", arguments: [self.travelPlace.title!])
                    self.detailViewLabel.textColor = UIColor.blackColor()
                    self.setupDetailView()
            })
        }
    }
    
    func setupDetailView() {
        let textView = UITextView(frame: CGRectMake(8, 8, 320-8-8, 120))
        textView.editable = false
        let titleFont = UIFont(name: "AvenirNext-Medium", size: 17)
        let textFont = UIFont(name: "AvenirNext-Medium", size: 12)
        let titleString = NSAttributedString(string: self.travelPlace.title!, attributes: [NSFontAttributeName:titleFont!])
        let textString = NSAttributedString(string: currentTripDictionary[self.travelPlace.title!]!, attributes: [NSFontAttributeName:textFont!])
        let descString = NSMutableAttributedString()
        descString.appendAttributedString(titleString)
        descString.appendAttributedString(NSAttributedString(string: "\n\n", attributes: [NSFontAttributeName:textFont!]))
        descString.appendAttributedString(textString)
        textView.attributedText = descString
//        textView.text = self.travelPlace.title! + "\n\n" + currentTripDictionary[self.travelPlace.title!]!
        self.detailScrollView .addSubview(textView)
        
        // horizontal view
        let horizontalLine = UIView(frame: CGRectMake(8, textView.frame.size.height + textView.frame.origin.y + 8, 320-8-8, 1))
        horizontalLine.backgroundColor = UIColor.grayColor()
        self.detailScrollView .addSubview(horizontalLine)
        
        // todo tableview
        let todoLabel = UILabel(frame: CGRectMake(8, horizontalLine.frame.origin.y + 9, 320-8-8, 20))
        todoLabel.text = "Things to do here:"
        todoLabel.font = titleFont
        self.todoTableView = UITableView(frame: CGRectMake(8, todoLabel.frame.origin.y + todoLabel.frame.size.height + 8, 320-8-8, 100), style: .Grouped)
        self.todoTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        self.todoTableView.allowsSelection = false
        self.todoTableView.backgroundColor = UIColor.whiteColor()
        self.detailScrollView.addSubview(todoLabel)
        self.detailScrollView.addSubview(self.todoTableView)
        // update contentSize
        self.detailScrollView.contentSize = CGSizeMake(self.detailScrollView.frame.size.width, self.todoTableView.frame.origin.y + self.todoTableView.frame.size.height + 8)
    }
    
    func showDetail(annotation: MKAnnotation) {
        let currentTravelPlace = annotation as! TravelPlaces
        travelPlace = currentTravelPlace;
        bringUpDetailView()
    }
    
    func bringDownDetailView(sender: UITapGestureRecognizer) {
        let tapGesture = sender as UITapGestureRecognizer;
        
        let tapPoint = tapGesture.locationInView(self.mapView);
        let coord = mapView.convertPoint(tapPoint, toCoordinateFromView: mapView)
        
        NSLog("World coordinate was longitude %f, latitude %f", coord.longitude, coord.latitude);
        let newY = 506 as CGFloat
        let heightMoved = self.detailView.frame.origin.y - newY;
        if (heightMoved < 0) {
            UIView.animateWithDuration(0.2, animations: {
                self.detailView.frame = CGRectMake(0, newY, self.detailView.frame.size.width, self.detailView.frame.size.height)
                }, completion: {
                    finished in
                    self.detailScrollView.hidden = true
            })
        }
    }
    
    
    // MARK uitableview datasource and delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.todoTableView) {
            return (self.thingsToDoDictionary[self.travelPlace.title!]?.count)!
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 24
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.thingsToDoDictionary[self.travelPlace.title!]![indexPath.row]
        
        return cell
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
        
        self.currentLocation = location;
        
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
    
    // MARK navigation
    func goToFullItinerary() {
        let fullItineraryVC = FullItineraryViewController()
        fullItineraryVC.tripTitle = "4 Days Trip in San Francisco"
        self.navigationController?.pushViewController(fullItineraryVC, animated: true)
    }

}
