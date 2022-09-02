//
//  Launch.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import Foundation
import UIKit

enum Outcome: String, Codable {
    case noOutcomeToReport = "No Outcome to Report"
    case success = "Success"
    case failure = "Failure"
    case partialSuccess = "Partial Success"
    case unknown = "Unknown"
}

enum Rocket: String, Codable {
    case falcon1 = "Falcon 1"
    case falcon9 = "Falcon 9"
    case falconHeavy = "Falcon Heavy"
}

enum BoosterVariant: String, Codable {
    case noVariant = "No Variant"
    case block1 = "Block 1"
    case block2 = "Block 2"
    case block3 = "Block 3"
    case block4 = "Block 4"
    case block5 = "Block 5"
}

enum RecoveryMethod: String, Codable {
    case noRecoveryMethod = "No Recovery Method"
    case parachute = "Parachute"
    case splashdown = "Controlled Splashdown"
    case landing = "Propulsive Landing"
    case catchingNet = "Net Catch"
    case aborted = "Aborted"
}

enum LaunchLocation: String, Codable {
    case kwajaleinAtoll = "KWA"
    case vandenbergAirForceBase = "VAFB"
    case vandenbergSpaceForceBase = "VSFB"
    case capeCanaveralAirForceStation = "CCAFS"
    case capeCanaveralSpaceForceStation = "CCSFS"
    case kennedy = "KSC"
    
    func getFullName() -> String {
        switch self {
        case .kwajaleinAtoll:
            return "Kwajalein Atoll"
        case .vandenbergAirForceBase:
            return "Vandenberg Air Force Base"
        case .vandenbergSpaceForceBase:
            return "Vandenberg Air Force Base"
        case .capeCanaveralAirForceStation:
            return "Cape Canaveral Air Force Station"
        case .capeCanaveralSpaceForceStation:
            return "Cape Canaveral Space Force Station"
        case .kennedy:
            return "Kennedy Space Center"
        }
    }
    
    func getShortName() -> String {
        switch self {
        case .kwajaleinAtoll:
            return "Kwajalein"
        case .vandenbergAirForceBase, .vandenbergSpaceForceBase:
            return "Vandenberg"
        case .capeCanaveralAirForceStation, .capeCanaveralSpaceForceStation:
            return "Cape Canaveral"
        case .kennedy:
            return "Kennedy"
        }
    }
}

enum LandingLocation: String, Codable {
    case noLandingLocation = "No Landing Location"
    case atlanticOcean = "ATL"
    case pacificOcean = "PAC"
    case droneShip = "ASDS"
    case fairingCatcher = "NET"
    case landingZone1 = "LZ-1"
    case landingZone2 = "LZ-2"
    case landingZone4 = "LZ-4"
}

enum OrbitalLocation: String, Codable {
    case leo = "LEO"
    case sso = "SSO"
    case gto = "GTO"
    case meo = "MEO"
    case heo = "HEO"
    case iss = "ISS"
    case pleo = "PLEO"
    case sel1 = "SEL1"
    case sub = "SUB"
    case helio = "HELIO"
    case tli = "TLI"
    
    func returnOrbitalLocationFullName() -> String {
        switch self {
        case .leo:
            return "Low Earth Orbit"
        case .sso:
            return "Sun-Synchronous Orbit"
        case .gto:
            return "Geostationary Transfer Orbit"
        case .meo:
            return "Medium Earth Orbit"
        case .heo:
            return "High Earth Orbit"
        case .iss:
            return "Low Earth Orbit (ISS)"
        case .pleo:
            return "Polar Low Earth Orbit"
        case .sel1:
            return "Sun Earth L1 Largrange Point"
        case .sub:
            return "Suborbital"
        case .helio:
            return "Heliocentric Orbit"
        case .tli:
            return "Trans Lunar Injection Orbit"
        }
    }
}

struct Customer: Codable {
    let customerName: String
    let customerAbbreviation: String
    let customerWikipediaPageLink: String
    let customerWebsiteLink: String
}

struct SupportVessel: Codable {
    let supportVesselName: String
    let supportVesselFormerNames: [String]
    let internationalMaritimeOrganizationNumber: Int
    let supportVesselOwner: String
    let supportVesselOperator: String
    let yearBuilt: Int
    let hullLength: Double
    let hullWidth: Double
    let yearJoinedSupportFleet: Int
    let yearLeftSupportFleet: Int
    let fullSpecificationSheet: String
}

struct LaunchSiteOrLandingZone: Codable {
    let launchSiteShortName: String
    let launchsiteFullName: String
    let launchSiteAbbreviation: String
    let launchSiteLatitude: Double
    let launchSiteLongitude: Double
    let launchPadName: String
    let launchPadAbbreviation: String
    let launchPadLatitude: Double
    let launchPadLongitude: Double
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
    let orbitalDestination: OrbitalLocation //Also could be redone
    let customerArray: [String] //Need to update data in .json file becausee may rideshare missions are missing customers such as starlink and others
    
    let staticFirePerformed: Bool
    let staticFireToLaunchGap: Int
    
    let boosterNumbers: [String]
    let boosterVariant: BoosterVariant
    let boosterRecoveryAttempted: Bool
    let boosterRecoveryMethod: RecoveryMethod
    let boosterRecoveryDistance: [Double]
    let boosterRecoveryLocations: [LandingLocation]
    let boosterRecoveryOutcome: [Outcome]
    let fairingVersion: Double
    let fairingFlights: [Int]
    let fairingRecoveryAttempted: Bool
    let fairingPlannedRecoveryMethod: [RecoveryMethod]
    let fairingActualRecoveryMethod: [RecoveryMethod]
    let fairingRecoveryDistance: Int
    
    //Location where the fairing actually landed
    let fairingRecoveryLocations: [LandingLocation]
    
    //If damaged = Failure, uncovered = Partial Success
    let fairingRecoveryOutcome: [Outcome]
    
    let missionSupportShips: [String]
    let missionSupportShipRoles: [String]
    
    let missionOutcome: Outcome
    //let webcastLink: String
}

public class LaunchLoader {
    @Published var allLaunches = [Launch]()
    
    init() {
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

public class SupportVesselLoader {
    @Published var allSupportVessels = [SupportVessel]()
    
    init() {
        if let fileLocation = Bundle.main.url(forResource: "supportvessel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([SupportVessel].self, from: data)
                
                self.allSupportVessels = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
