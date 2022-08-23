//
//  LaunchDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/10/22.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    @IBOutlet weak var initialLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    let completeSetOfLaunchData = LaunchLoader().allLaunches
    
    var currentLaunch = Launch(launchID: 0, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", alternativeAbbreviatedLaunchName: "", liftOffTime: "", launchLocation: .capeCanaveralAirForceStation, launchVehicle: .falcon1, launchVehicleVariant: .block1, boosterRecoveryAttempted: true, boosterRecoveryMethod: .catchingNet, boosterRecoveryOutcome: .unknown, fairingRecoveryAttempted: true, plannedFairingRecoveryMethod: .catchingNet, actualFairingRecoveryMethod: .catchingNet, fairingRecoveryOutcome: .unknown, missionOutcome: .unknown)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
        var counter = 0
        
        //Display mission success streak
        var successfulMissionInARow = 0, totalFailedMission = 0
        
        //Display what number launch of this vehicle this mission is
        var totalNumberOfLaunchesOfVehicle = 0
        
        //Display what number launch this is from this site
        var launchNumberFromCurrentLaunchSite = 0
        
        while(counter < currentLaunch.launchID) {
            if(completeSetOfLaunchData[counter].missionOutcome == .success || completeSetOfLaunchData[counter].missionOutcome == .partialSuccess) {
                successfulMissionInARow += 1
            } else {
                successfulMissionInARow = 0
                totalFailedMission += 1
            }
            
            if(completeSetOfLaunchData[counter].launchVehicle == currentLaunch.launchVehicle) {
                totalNumberOfLaunchesOfVehicle += 1
            }
            
            if(completeSetOfLaunchData[counter].launchLocation == currentLaunch.launchLocation) {
                launchNumberFromCurrentLaunchSite += 1
            }
            
            counter += 1
        }
        
        initialLabel.text = "\(currentLaunch.launchID)" + attachSuffixToNumber(currentValue: currentLaunch.launchID) + " overall launch by SpaceX"
        print(initialLabel.text!)
        
        if(currentLaunch.missionOutcome == .success || currentLaunch.missionOutcome == .partialSuccess) {
            secondLabel.text = "\(successfulMissionInARow)" + attachSuffixToNumber(currentValue: successfulMissionInARow) + " succesful mission in a row for SpaceX"
        } else {
            secondLabel.text = "\(totalFailedMission)" + attachSuffixToNumber(currentValue: totalFailedMission) + " failed mission for SpaceX"
        }
        print(secondLabel.text!)
        
        //Display what number launch of this vehicle this mission is
        thirdLabel.text = "\(totalNumberOfLaunchesOfVehicle)" + attachSuffixToNumber(currentValue: totalNumberOfLaunchesOfVehicle) + " launch of the " + currentLaunch.launchVehicle.rawValue + " launch vehicle"
        print(thirdLabel.text!)
        
        fourthLabel.text = String(launchNumberFromCurrentLaunchSite) + attachSuffixToNumber(currentValue: launchNumberFromCurrentLaunchSite) + " SpaceX launch from \(currentLaunch.launchLocation.getFullName())"
        print(fourthLabel.text!)
        
        func attachSuffixToNumber(currentValue: Int) -> String {
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

}
