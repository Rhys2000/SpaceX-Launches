//
//  LaunchDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/10/22.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    static let identifier = "LaunchDetailViewController"
    
    var currentLaunch = Launch(launchID: 1, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", alternativeAbbreviatedLaunchName: "", liftOffTime: "", launchLocation: .capeCanaveralSpaceForceStation, launchVehicle: .falcon1, orbitalDestination: .leo, customerArray: [""], staticFirePerformed: true, staticFireToLaunchGap: 2, boosterNumbers: ["2"], boosterVariant: .block1, boosterRecoveryAttempted: true, boosterRecoveryMethod: .aborted, boosterRecoveryDistance: [1], boosterRecoveryLocations: [.droneShip], boosterRecoveryOutcome: [.failure], fairingVersion: 1, fairingFlights: [4], fairingRecoveryAttempted: true, fairingPlannedRecoveryMethod: [.aborted], fairingActualRecoveryMethod: [.aborted], fairingRecoveryDistance: 1, fairingRecoveryLocations: [.droneShip], fairingRecoveryOutcome: [.failure], missionSupportShips: [""], missionSupportShipRoles: [""], missionOutcome: .failure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
    }
        
    func getSuffixForNumber(currentValue: Int) -> String {
        if(currentValue == 11 || currentValue == 12 || currentValue == 13) {
            return "th"
        } else {
            switch(currentValue % 10) {
            case 1:
                return "st"
            case 2:
                return "nd"
            case 3:
                return "rd"
            default:
                return "th"
            }
        }
    }
    
}
