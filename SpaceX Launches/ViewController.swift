//
//  ViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/4/22.
//

import UIKit

struct RocketLaunch {
    var missionName: String = ""
    var liftOffDate = DateComponents()
    var launchProvider: String = ""
    var launchCustomers: [String] = [""]
    var payloads: [String] = [""]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var Time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var launch = RocketLaunch()
        launch.launchProvider = "SpaceX"
        launch.launchCustomers = ["NASA", "Intelsat"]
        launch.payloads = ["Starlink", "Sentinel-6", "JWST"]
        print(launch.launchProvider + launch.launchCustomers[0] + launch.payloads[0])
        let now = Date()
        print("It’s been \(now.timeIntervalSinceReferenceDate) seconds since the start of the Third Millennium.")
        print(now.description(with: Locale(identifier: "en-US")))
        let localTimeZoneIdentifier: String = TimeZone.current.identifier
        print(localTimeZoneIdentifier)
        Time.text = localTimeZoneIdentifier
        let launchDate = DateComponents()
        // Do any additional setup after loading the view.
    }


}

