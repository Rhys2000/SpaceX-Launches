//
//  Launch.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import Foundation
import UIKit

enum Outcome: String, Codable {
    case success = "Success"
    case partialSuccess = "Partial Success"
    case failure = "Failure"
    case upcoming = "Upcoming"
    case unknown = "Unknown"
    case noOutcomeToDiscern = "NA"
}

enum Rocket: String, Codable {
    case falcon1 = "Falcon 1"
    case falcon9 = "Falcon 9"
    case falconHeavy = "Falcon Heavy"
}

enum RocketVariant: String, Codable {
    case block1 = "Block 1"
    case block2 = "Block 2"
    case block3 = "Block 3"
    case block4 = "Block 4"
    case block5 = "Block 5"
    case noApplicableVariant = "NA"
}

enum RecoveryMethod: String, Codable {
    case parachute = "Parachute"
    case controlledSplashdown = "Controlled Splashdown"
    case propulsiveLanding = "Propulsive Landing"
    case catchingNet = "Catch in Net"
    case catchingNetControlledSplashdown = "Catch in Net/Controlled Splashdown"
    case doubleCatch = "Double Catch"
    case noAttemptMade = "NA"
}

enum LaunchLocation: String, Codable {
    case kwajaleinAtoll = "KWA"
    case vandenbergAirForceBase = "VAFB"
    case vandenberrgSpaceForceBase = "VSFB"
    case capeCanaveralAirForceStation = "CCAFS"
    case capeCanaveralSpaceForceStation = "CCSFS"
    case kennedy = "KSC"
    
    func getFullName() -> String {
        switch self {
        case .kwajaleinAtoll:
            return "Kwajalein Atoll"
        case .vandenbergAirForceBase:
            return "Vandenberg Air Force Base"
        case .vandenberrgSpaceForceBase:
            return "Vandenberg Air Force Base"
        case .capeCanaveralAirForceStation:
            return "Cape Canaveral Air Force Station"
        case .capeCanaveralSpaceForceStation:
            return "Cape Canaveral Space Force Station"
        case .kennedy:
            return "Kennedy Space Center"
        }
    }
}

struct Customer: Codable {
    let customerName: String
    let customerAbbreviation: String
    let customerWikipediaPageLink: String
    let customerWebsiteLink: String
}

struct LaunchSite: Codable {
    let launchSiteShortName: String
    let launchsiteFullName: String
    let launchSiteAbbreviation: String
    let launchSiteLatitude: Double
    let launchSiteLongitude: Double
    let launchPadName: String
    let launchPadAbbreviation: String
    let launchPadLatitude: Double
    let launchPadLongitude: Double
    let siteStatus: Bool
}

struct Launch: Codable {
    let launchID: Int
    let launchName: String
    let alternativeLaunchName: String
    let abbreviatedLaunchName: String
    let alternativeAbbreviatedLaunchName: String
    let liftOffTime: String
    let launchLocation: LaunchLocation
    let launchVehicle: Rocket
    let launchVehicleVariant: RocketVariant
    //let customerArray: [String] figure out next important for rideshare missions
    let boosterRecoveryAttempted: Bool
    let boosterRecoveryMethod: RecoveryMethod
    let boosterRecoveryOutcome: Outcome
    //let boosterRecoveryLocations: [String]
    let fairingRecoveryAttempted: Bool
    let plannedFairingRecoveryMethod: RecoveryMethod
    let actualFairingRecoveryMethod: RecoveryMethod
    let fairingRecoveryOutcome: Outcome
    //let fairingRecoveryLocations: [String]
    let missionOutcome: Outcome
}

public class LaunchLoader {
    @Published var allLaunches = [Launch]()
    
    init() {
        loadLaunches()
    }
    
    func loadLaunches() {
        if let fileLocation = Bundle.main.url(forResource: "launch", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Launch].self, from: data)
                
                self.allLaunches = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
