//
//  CULocationViewController.swift
//  MFCUTest
//
//  Created by Cotter on 9/9/16.
//  Copyright © 2016 Cotter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CULocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    private var locationManager: CLLocationManager?
    private var newestLocation = CLLocation()
    private var userLocation = MKCoordinateRegion()
    private var branchLocations = [MFCULocation]()
    private var selectedRowIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        getUserLocation()
        let location = MFCULocation()
        location.getBranchLocations {
            (locations) in
            self.branchLocations = locations
            self.addBranchLocationsToMap(locations)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupMapView() {
        guard let mapView = mapView else { return }
        mapView.delegate = self
        mapView.showsPointsOfInterest = false
        mapView.showsUserLocation = true
    }
    
    private func setMapRegion(withMFCULocation: MFCULocation){
        var mapRegion = mapView.region
        mapRegion.center = withMFCULocation.coordinate
        mapView.setRegion(mapRegion, animated: true)
    }
    
    private func addBranchLocationsToMap(locations:[MFCULocation]) {
        for branchLocation in locations {
            mapView.addAnnotation(branchLocation)
        }
    }

    //MARK: Location Methods
    private func getUserLocation() {
        locationManager = CLLocationManager()
        guard let manager = locationManager else { return }
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
        manager.distanceFilter = 100
        manager.startUpdatingLocation()
        guard let managerLocation = manager.location else { return }
        newestLocation = managerLocation
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        newestLocation = lastLocation
        userLocation = MKCoordinateRegionMakeWithDistance(newestLocation.coordinate, 800, 800)
        mapView.setRegion(userLocation, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchLocations.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CUBranchLocationCell
        let branch = branchLocations[indexPath.row]
        cell.branchNameLabel.text = branch.branchName
        cell.addressLabel.text = branch.address
        cell.detailTextLabel?.text = branch.branchDetails
        cell.distance.text = branch.distance
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return 140
        }
        return 35
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedRowIndex != indexPath.row {
            let selectedLocation = branchLocations[indexPath.row]
            setMapRegion(selectedLocation)
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0))?.backgroundColor = UIColor.whiteColor()
            selectedRowIndex = indexPath.row
            self.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.whiteColor()
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    

}
