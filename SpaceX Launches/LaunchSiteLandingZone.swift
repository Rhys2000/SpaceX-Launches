//
//  LaunchSiteLandingZone.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/23/22.
//

import Foundation

struct LaunchSiteLandingZone: Codable {
    let launchSiteShortName: String
    let launchSiteFullName: String
    let launchSiteAbbreviation: String
    let launchSiteLatitude: Double
    let launchSiteLongitude: Double
    let launchSiteTerritory: String
    let launchSiteCountry: String
    let launchPadName: String
    let launchPadAbbreviation: String
    let launchPadLatitude: Double
    let launchPadLongitude: Double
}

public class LaunchSiteLandingZoneLoader {
    @Published var allLocations = [LaunchSiteLandingZone]()
    
    init() {
        if let fileLocation = Bundle.main.url(forResource: "launchsitelandingzone", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([LaunchSiteLandingZone].self, from: data)
                
                self.allLocations = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
