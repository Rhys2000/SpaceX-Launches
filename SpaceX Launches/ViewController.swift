//
//  ViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/4/22.
//

import UIKit

struct RocketLaunch {
    var launchName: String = ""
    var alternativeLaunchName: String = ""
    var launchDateAndTime: String = "" //Written in ISO8601 format (2022-08-04T23:08:00+0000)
    var launchProvider: String = ""
    var launchCustomers: [String] = [""]
    var payloads: [String] = [""]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var ExpectedUTC: UILabel!
    @IBOutlet weak var ExpectedLocal: UILabel!
    @IBOutlet weak var Actual: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var launch = RocketLaunch()
        launch.launchName = "KPLO"
        launch.alternativeLaunchName = "Korean Pathfinder Lunar Orbiter"
        launch.launchProvider = "SpaceX"
        launch.launchCustomers = ["NASA", "Intelsat"]
        launch.payloads = ["Starlink", "Sentinel-6", "JWST"]
        print(launch.launchProvider + launch.launchCustomers[0] + launch.payloads[0])
        
        let missionName = launch.launchName + " (" + launch.alternativeLaunchName + ")"
        ExpectedUTC.text = missionName
        ExpectedUTC.adjustsFontSizeToFitWidth = true
        
        
        let isoDate = "2022-08-04T23:08:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let tempDate = dateFormatter.date(from: isoDate)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tempDate)
        
        let localDate = calendar.date(from: components)!
        dateFormatter.dateFormat = "E, MMMM dd, yyyy h:mm:ss a"
        var launchDate = dateFormatter.string(from: localDate) + " (" + TimeZone.current.abbreviation()! + ") / "
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "HH:dd:ss"
        launchDate += dateFormatter.string(from: localDate) + " (UTC) "
        ExpectedLocal.text = launchDate
        ExpectedLocal.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }


}

