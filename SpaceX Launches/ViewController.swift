//
//  ViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/4/22.
//

import UIKit

struct SpaceXLaunch {
    var launchName: String = ""
    var alternativeLaunchName: String = ""
    var launchDateAndTime: String = "" //Written in ISO8601 format (2022-08-04T23:08:00+0000)
    var launchProvider: String = "Space Exploration Technologies Corporation"
    var launchProviderAbbreviation: String = "SpaceX"
    var launchCustomers: [String] = [""]
    var launchPayloads: [String] = [""]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var ExpectedUTC: UILabel!
    @IBOutlet weak var ExpectedLocal: UILabel!
    @IBOutlet weak var Actual: UILabel!
    @IBOutlet weak var Customers: UILabel!
    @IBOutlet weak var Payload: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var launch = SpaceXLaunch()
        launch.launchName = "KPLO"
        launch.alternativeLaunchName = "Korean Pathfinder Lunar Orbiter"
        launch.launchCustomers = ["Korea Aerospace Research Institute (KARI)", "National Aeronautics and Space Administration (NASA)"]
        launch.launchPayloads = ["Korean Pathfinder Lunar Orbiter"]
        
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
        
        let rocketProvider = launch.launchProvider + " (" + launch.launchProviderAbbreviation + ")"
        Actual.text = rocketProvider
        Actual.adjustsFontSizeToFitWidth = true
        
        var missionCustomers: String = ""
        for customer in launch.launchCustomers{
            missionCustomers += customer + ", \n"
        }
        Customers.text = missionCustomers
        let customersHeight = Customers.optimalHeight
        Customers.frame = CGRect(x: Customers.frame.origin.x, y: Customers.frame.origin.y, width: Customers.frame.width, height: customersHeight)
        Customers.backgroundColor = UIColor.yellow
        Customers.numberOfLines = 0
        
        var missionPayloads: String = ""
        for payload in launch.launchPayloads{
            missionPayloads += payload + ", \n"
        }
        Payload.text = missionPayloads
        let payloadsHeight = Customers.optimalHeight
        Payload.frame = CGRect(x: Payload.frame.origin.x, y: Payload.frame.origin.y, width: Payload.frame.width, height: payloadsHeight)
        Payload.backgroundColor = UIColor.green
        Payload.numberOfLines = 0
    }
}

extension UILabel {
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
}

