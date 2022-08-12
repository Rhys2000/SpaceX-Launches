//
//  LaunchDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/10/22.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    var currentLaunch = Launch(launchID: 0, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", liftOffTime: "", missionOutcome: .upcoming)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
        // Do any additional setup after loading the view.
    }

}
