//
//  LaunchDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/10/22.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    var currentLaunch = Launch(launchID: 0, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", alternativeAbbreviatedLaunchName: "", liftOffTime: "", launchVehicle: .falcon1, launchVehicleVariant: .block1, boosterRecoveryAttempted: true, missionOutcome: .unknown)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
        // Do any additional setup after loading the view.
    }

}
