//
//  TravelPlaces.swift
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/11/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import Foundation
import MapKit

class TravelPlaces: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}