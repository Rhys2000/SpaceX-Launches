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
    case tbd = "To Be Determined"
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
    case expendeds = "Expended"
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
    case geo = "GEO"
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
            return "Low Earth Orbit"
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
        case .geo:
            return "Geosychronous Equatorial Orbit"
        }
    }
}

struct Launch: Codable {
    let launchID: Int
    let launchName: String
    let abbreviatedLaunchName: String
    let alternativeLaunchName: String
    let liftOffTime: String
    let launchLocation: LaunchLocation
    let launchVehicle: Rocket
    let orbitalDestination: OrbitalLocation //Also could be redone
    let finalOrbitalInsertion: [Double]
    let launchProvider: String
    let launchProviderLink: String
    let customerArray: [String]
    let cosparCode: String //Will apply to a satellite of payload which are both made form the same superclass
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
    
    func returnOutcomeColor(outcome: Outcome) -> CGColor {
        switch(outcome) {
        case .success:
            return UIColor.green.cgColor
        case .noOutcomeToReport:
            return UIColor.black.cgColor
        case .failure:
            return UIColor.red.cgColor
        case .partialSuccess:
            return UIColor.systemMint.cgColor
        case .unknown:
            return UIColor.blue.cgColor
        case .tbd:
            return UIColor.yellow.cgColor
        }
    }
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
