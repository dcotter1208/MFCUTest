//
//  MFCUAnnotation.swift
//  MFCUTest
//
//  Created by Cotter on 9/9/16.
//  Copyright © 2016 Cotter. All rights reserved.
//

import Foundation
import MapKit

class MFCUAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}