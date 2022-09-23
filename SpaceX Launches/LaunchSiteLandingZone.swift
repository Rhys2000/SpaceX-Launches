//
//  LaunchSiteLandingZone.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/23/22.
//

import Foundation

struct LaunchSiteLandingZone: Codable {
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

