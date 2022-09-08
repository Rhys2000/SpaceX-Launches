//
//  SupportVesselHomePortViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/7/22.
//

import UIKit
import MapKit

class SupportVesselHomePortViewController: UIViewController {
    
    static let identifier = "SupportVesselHomePortViewController"
    
    var homeport: String = ""
    var latitude = Double()
    var longitude = Double()
    
    private let homePortMapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = homeport
        
        homePortMapView.mapType = .hybridFlyover
        homePortMapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        view.addSubview(homePortMapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homePortMapView.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height - (tabBarController?.tabBar.frame.height)!)
    }

}
