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
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    @IBOutlet weak var seventhLabel: UILabel!
    @IBOutlet weak var eighthLabel: UILabel!
    @IBOutlet weak var ninthLabel: UILabel!
    @IBOutlet weak var tenthLabel: UILabel!
    @IBOutlet weak var eleventhLabel: UILabel!
    @IBOutlet weak var twelthLabel: UILabel!
    @IBOutlet weak var thirteethLabel: UILabel!
    @IBOutlet weak var fourteenthLabel: UILabel!
    
    let completeSetOfLaunchData = LaunchLoader().allLaunches
    
    var currentLaunch = Launch(launchID: 1, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", alternativeAbbreviatedLaunchName: "", liftOffTime: "", launchLocation: .capeCanaveralSpaceForceStation, launchVehicle: .falcon1, orbitalDestination: .leo, customerArray: [""], boosterNumbers: ["2"], boosterVariant: .block1, boosterRecoveryAttempted: true, boosterRecoveryMethod: .aborted, boosterRecoveryDistance: [1], boosterRecoveryLocations: [.droneShip], boosterRecoveryOutcome: [.failure], fairingVersion: 1, fairingFlights: [4], fairingRecoveryAttempted: true, fairingPlannedRecoveryMethod: [.aborted], fairingActualRecoveryMethod: [.aborted], fairingRecoveryDistance: 1, fairingRecoveryLocations: [.droneShip], fairingRecoveryOutcome: [.failure], missionSupportShips: [""], missionOutcome: .failure)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
        var counter = 0
        
//        for customer in currentLaunch.customerArray {
//            print(customer)
//        }
        
        //Components to retrieve the year a launch occured in
        let dateFormatter = DateFormatter(), calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //Display overall success/failure number
        var overallMissionSuccess = 0, overallMissionFailure = 0 //secondLabel
        
        //Display overall SpaceX mission success streak
        var overallMissionSuccessesInARow = 0, overallMissionFailuresInARow = 0 //thirdLabel
        
        //Display overall number of SpaceX missions this year
        var overallMissionsThisYear = 0 //fourthLabel
        
        //Display the overall number of missions for this vehicle
        var overallLaunchNumberForLaunchVehicle = 0 //fifthLabel
        
        //Display overall success/failure number of launch vehicle
        var overallVehicleSuccesses = 0, overallVehicleFailures = 0 //sixthLabel

        //Display launchVehicle success streak
        var vehicleMissionSuccessesInARow = 0, vehicleMissionFailuresInARow = 0 //seventhLabel
        
        //Display the number of launches for this launch vehicle this year
        var vehicleMissionsThisYear = 0 //eighthLabel
        
        //Display overall number of mission from this launch location
        var overallLaunchNumberFromLaunchLocation = 0, overallLaunchNumberFromVandenberg = 0, overallLaunchNumberFromCapeCanaveral = 0 //ninthLabel
        
        //Display number of launches of certain launch vehicle from certain launch location
        var vehicleMissionFromLaunchLocation = 0, vehicleMissionFromVandenberg = 0, vehicleMissionFromCapeCanaveral = 0 //tenthLabel
        
        //Display overall number of launches to orbital destination
        var overallMissionsToOrbitalDestination = 0 //eleventhLabel
        
        //Display number of booster recoveries attempted
        var overallBoosterRecoveriesAttempted = 0, overallBoosterRecoveriesNotAttempted = 0 //twelfthLabel
        
        //Display number of successful booster recoveries
        var overallBoosterRecoverySuccesses = 0, overallBoosterRecoveryFailures = 0, overallBoosterRecoveryPartialSuccesses = 0, overallBoosterRecoveryNoOutcome = 0 //thirteenthLabel
        
        //Display number of flights for a vehicle variant
        var overallLaunchNumberForLaunchVehicleVariant = 0
        
        //Iterate through each element of the completeSetOfLaunchData up to the currentLaunch
        while(counter < currentLaunch.launchID) {
            
            //Determine what number success/failure this mission is overall
            if(completeSetOfLaunchData[counter].missionOutcome == .success || completeSetOfLaunchData[counter].missionOutcome == .partialSuccess) {
                overallMissionSuccess += 1
                overallMissionSuccessesInARow += 1
                overallMissionFailuresInARow = 0
                if(completeSetOfLaunchData[counter].launchVehicle == currentLaunch.launchVehicle) {
                    overallLaunchNumberForLaunchVehicle += 1
                    overallVehicleSuccesses += 1
                    vehicleMissionSuccessesInARow += 1
                    vehicleMissionFailuresInARow = 0
                }
            } else {
                overallMissionFailure += 1
                overallMissionFailuresInARow += 1
                overallMissionSuccessesInARow = 0
                if(completeSetOfLaunchData[counter].launchVehicle == currentLaunch.launchVehicle) {
                    overallLaunchNumberForLaunchVehicle += 1
                    overallVehicleFailures += 1
                    vehicleMissionFailuresInARow += 1
                    vehicleMissionSuccessesInARow = 0
                }
            }
            
            if(completeSetOfLaunchData[counter].launchLocation == .capeCanaveralAirForceStation || completeSetOfLaunchData[counter].launchLocation == .capeCanaveralSpaceForceStation) {
                overallLaunchNumberFromCapeCanaveral += 1
                if(completeSetOfLaunchData[counter].launchLocation == currentLaunch.launchLocation) {
                    vehicleMissionFromCapeCanaveral += 1
                }
            } else if(completeSetOfLaunchData[counter].launchLocation == .vandenbergAirForceBase || completeSetOfLaunchData[counter].launchLocation == .vandenbergSpaceForceBase) {
                overallLaunchNumberFromVandenberg += 1
                if(completeSetOfLaunchData[counter].launchLocation == currentLaunch.launchLocation) {
                    vehicleMissionFromVandenberg += 1
                }
            } else {
                overallLaunchNumberFromLaunchLocation += 1
                if(completeSetOfLaunchData[counter].launchLocation == currentLaunch.launchLocation) {
                    vehicleMissionFromLaunchLocation += 1
                }
            }

            if(calendar.dateComponents([.year], from: dateFormatter.date(from: completeSetOfLaunchData[counter].liftOffTime)!) == calendar.dateComponents([.year], from: dateFormatter.date(from: currentLaunch.liftOffTime)!)) {
                overallMissionsThisYear += 1
                if(completeSetOfLaunchData[counter].launchVehicle == currentLaunch.launchVehicle) {
                    vehicleMissionsThisYear += 1
                }
            }
            
            if(completeSetOfLaunchData[counter].orbitalDestination == currentLaunch.orbitalDestination) {
                overallMissionsToOrbitalDestination += 1
            }
            
            if(completeSetOfLaunchData[counter].boosterRecoveryAttempted) {
                overallBoosterRecoveriesAttempted += 1
            } else {
                overallBoosterRecoveriesNotAttempted += 1
            }
            
//            if(completeSetOfLaunchData[counter].boosterRecoveryOutcome == .success) {
//                overallBoosterRecoverySuccesses += 1
//            } else if(completeSetOfLaunchData[counter].boosterRecoveryOutcome == .partialSuccess) {
//                overallBoosterRecoveryPartialSuccesses += 1
//            } else if(completeSetOfLaunchData[counter].boosterRecoveryOutcome == .failure) {
//                overallBoosterRecoveryFailures += 1
//            } else {
//                overallBoosterRecoveryNoOutcome += 1
//            }
//
//            if(completeSetOfLaunchData[counter].launchVehicleVariant == currentLaunch.launchVehicleVariant && completeSetOfLaunchData[counter].launchVehicle == currentLaunch.launchVehicle) {
//                overallLaunchNumberForLaunchVehicleVariant += 1
//            }
            
            counter += 1
        }
        
        //Overall launch number (AKA launchID)
        initialLabel.text = String(currentLaunch.launchID) + getSuffixForNumber(currentValue: currentLaunch.launchID) + " launch for SpaceX"
        fourthLabel.text = String(overallMissionsThisYear) + getSuffixForNumber(currentValue: overallMissionsThisYear) + " launch for SpaceX this year"
        fifthLabel.text = String(overallLaunchNumberForLaunchVehicle) + getSuffixForNumber(currentValue: overallLaunchNumberForLaunchVehicle) + " launch of the \(currentLaunch.launchVehicle.rawValue)"
        eighthLabel.text = String(vehicleMissionsThisYear) + getSuffixForNumber(currentValue: vehicleMissionsThisYear) + " launch of the \(currentLaunch.launchVehicle.rawValue) this year"
        tenthLabel.text = String(vehicleMissionFromLaunchLocation) + getSuffixForNumber(currentValue: vehicleMissionFromLaunchLocation) + " \(currentLaunch.launchVehicle.rawValue) launch from \(currentLaunch.launchLocation.getShortName())"
        eleventhLabel.text = String(overallMissionsToOrbitalDestination) + getSuffixForNumber(currentValue: overallMissionsToOrbitalDestination) + " mission to " + currentLaunch.orbitalDestination.returnOrbitalLocationFullName() + " for SpaceX"
        fourteenthLabel.text = String(overallLaunchNumberForLaunchVehicleVariant) + getSuffixForNumber(currentValue: overallLaunchNumberForLaunchVehicleVariant) + " flight of the \(currentLaunch.launchVehicle.rawValue) \(currentLaunch.boosterVariant.rawValue)"
        
        //If it was a successful/partially successful mission enter this code block
        if(currentLaunch.missionOutcome == .success || currentLaunch.missionOutcome == .partialSuccess) {
            secondLabel.text = String(overallMissionSuccess) + getSuffixForNumber(currentValue: overallMissionSuccess) + " successful mission for SpaceX"
            thirdLabel.text = String(overallMissionSuccessesInARow) + getSuffixForNumber(currentValue: overallMissionSuccessesInARow) + " succesful mission in a row for SpaceX"
            sixthLabel.text = String(overallVehicleSuccesses) + getSuffixForNumber(currentValue: overallVehicleSuccesses) + " successful mission for the \(currentLaunch.launchVehicle.rawValue)"
            seventhLabel.text = String(vehicleMissionSuccessesInARow) + getSuffixForNumber(currentValue: vehicleMissionSuccessesInARow) + " successful mission in a row for the \(currentLaunch.launchVehicle.rawValue)"
        } else {
            secondLabel.text = String(overallMissionFailure) + getSuffixForNumber(currentValue: overallMissionFailure) + " failed mission for SpaceX"
            thirdLabel.text = String(overallMissionFailuresInARow) + getSuffixForNumber(currentValue: overallMissionFailuresInARow) + " failed mission in a row for SpaceX"
            sixthLabel.text = String(overallVehicleFailures) + getSuffixForNumber(currentValue: overallVehicleFailures) + " failed mission for the \(currentLaunch.launchVehicle.rawValue)"
            seventhLabel.text = String(vehicleMissionFailuresInARow) + getSuffixForNumber(currentValue: vehicleMissionFailuresInARow) + " failed mission in a row for the \(currentLaunch.launchVehicle.rawValue)"
        }
            
        if(currentLaunch.launchLocation == .vandenbergAirForceBase || currentLaunch.launchLocation == .vandenbergSpaceForceBase) {
            ninthLabel.text = String(overallLaunchNumberFromVandenberg) + getSuffixForNumber(currentValue: overallLaunchNumberFromVandenberg) + " launch from \(currentLaunch.launchLocation.getShortName()) for SpaceX"
            tenthLabel.text = String(vehicleMissionFromVandenberg) + getSuffixForNumber(currentValue: vehicleMissionFromVandenberg) + " \(currentLaunch.launchVehicle.rawValue) launch from \(currentLaunch.launchLocation.getShortName())"
        } else if(currentLaunch.launchLocation == .capeCanaveralAirForceStation || currentLaunch.launchLocation == .capeCanaveralSpaceForceStation) {
            ninthLabel.text = String(overallLaunchNumberFromCapeCanaveral) + getSuffixForNumber(currentValue: overallLaunchNumberFromCapeCanaveral) + " launch from \(currentLaunch.launchLocation.getShortName()) for SpaceX"
            tenthLabel.text = String(vehicleMissionFromCapeCanaveral) + getSuffixForNumber(currentValue: vehicleMissionFromCapeCanaveral) + " \(currentLaunch.launchVehicle.rawValue) launch from \(currentLaunch.launchLocation.getShortName())"
        } else {
            ninthLabel.text = String(overallLaunchNumberFromLaunchLocation) + getSuffixForNumber(currentValue: overallLaunchNumberFromLaunchLocation) + " launch from \(currentLaunch.launchLocation.getShortName()) for SpaceX"
            tenthLabel.text = String(vehicleMissionFromLaunchLocation) + getSuffixForNumber(currentValue: vehicleMissionFromLaunchLocation) + " \(currentLaunch.launchVehicle.rawValue) launch from \(currentLaunch.launchLocation.getShortName())"
        }
        
        if(currentLaunch.boosterRecoveryAttempted) {
            twelthLabel.text = String(overallBoosterRecoveriesAttempted) + getSuffixForNumber(currentValue: overallBoosterRecoveriesAttempted) + " planned recovery of a booster"
        } else {
            twelthLabel.text = String(overallBoosterRecoveriesNotAttempted) + getSuffixForNumber(currentValue: overallBoosterRecoveriesNotAttempted) + " planned disposal of a booster"
        }
        
//        if(currentLaunch.boosterRecoveryOutcome == .success) {
//            thirteethLabel.text = String(overallBoosterRecoverySuccesses) + getSuffixForNumber(currentValue: overallBoosterRecoverySuccesses) + " successful recovery of a booster"
//        } else if(currentLaunch.boosterRecoveryOutcome == .partialSuccess) {
//            thirteethLabel.text = String(overallBoosterRecoveryPartialSuccesses) + getSuffixForNumber(currentValue: overallBoosterRecoveryPartialSuccesses) + " partial recovery of a booster"
//        } else if(currentLaunch.boosterRecoveryOutcome == .failure) {
//            thirteethLabel.text = String(overallBoosterRecoveryFailures) + getSuffixForNumber(currentValue: overallBoosterRecoveryFailures) + " failure to recover a booster"
//        } else {
//            thirteethLabel.text = String(overallBoosterRecoveryNoOutcome) + getSuffixForNumber(currentValue: overallBoosterRecoveryNoOutcome) + " unattempted recovery of a booster"
//        }
        
        if(currentLaunch.boosterVariant == .noVariant) {
            fourteenthLabel.text = "\(currentLaunch.launchVehicle.rawValue) does not have any variants"
        } else {
            fourteenthLabel.text = String(overallLaunchNumberForLaunchVehicleVariant) + getSuffixForNumber(currentValue: overallLaunchNumberForLaunchVehicleVariant) + " flight of the \(currentLaunch.launchVehicle.rawValue) \(currentLaunch.boosterVariant.rawValue)"
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
}
