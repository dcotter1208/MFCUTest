//
//  MCULocation.swift
//  MFCUTest
//
//  Created by Cotter on 9/9/16.
//  Copyright © 2016 Cotter. All rights reserved.
//

import Foundation
import MapKit

typealias BranchLocationResults = ([MFCULocation]) -> Void

class MFCULocation: NSObject, MKAnnotation {
    var branchName: String
    var address: String
    var branchDetails: String
    var distance: String
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    override init() {
        self.branchName = ""
        self.distance = ""
        self.address = ""
        self.branchDetails = ""
        self.coordinate = CLLocationCoordinate2D()
        self.title = ""
    }
    
    func createBranch(branchName:String, address: String, branchDetails: String, distance: String) {
        self.branchName = branchName
        self.address = address
        self.branchDetails = branchDetails
        self.distance = distance
    }
    
    func getBranchLocations(completion:BranchLocationResults) {
        let branchOne = MFCULocation()
        branchOne.createBranch("Michigan First Credit Union", address: "5057 Woodward Ave # 1, Detroit, MI 48202", branchDetails: "Walk-up, Handicap Access", distance: "0.5")
        setAnnotationCoordinateAndTitle(branchOne)
        let branchTwo = MFCULocation()
        branchTwo.createBranch("Michigan First CU-WSU Student Center", address: "5221 Gullen Mall, Detroit, MI 48202", branchDetails: "Walk-up, Handicap Access", distance: "0.4")
        setAnnotationCoordinateAndTitle(branchTwo)
        let branchThree = MFCULocation()
        branchThree.createBranch("Michigan First Credit Union", address: "3031 W Grand Blvd #208, Detroit, MI 48202", branchDetails: "Walk-up, Handicap Access", distance: "0.9")
        setAnnotationCoordinateAndTitle(branchThree)
        let branchFour = MFCULocation()
        branchFour.createBranch("People Driven MCU", address: "477 Michigan Ave M75, Detroit, MI 48226", branchDetails: "Walk-up, Handicap Access", distance: "1.2")
        setAnnotationCoordinateAndTitle(branchFour)
        let branches = [branchOne, branchTwo, branchThree, branchFour]
        completion(branches)
    }
    
    private func setAnnotationCoordinateAndTitle(branch: MFCULocation) {
        getAddressCoordinates(branch.address) {
            (coordinate) in
            branch.coordinate = coordinate
            branch.title = branch.branchName
        }
    }
    
    private func getAddressCoordinates(address: String, completion: (coordinate: CLLocationCoordinate2D) -> Void) {
        CLGeocoder().geocodeAddressString(address, completionHandler: {
            (placemarks, error) in
            if error != nil {
                print(error)
            } else {
                let placemark = placemarks![0]
                completion(coordinate: placemark.location!.coordinate)
            }
        })
    }
    
}