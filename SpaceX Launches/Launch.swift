//
//  Launch.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import Foundation
import UIKit

enum Outcome: String {
    
    case success = "Mission Success"
    case failure = "Mission Failure"
    case upcoming = "Upcoming Mission"
    case unknown = "Unknown Outcome"
}

struct Launch {
    let launchID: Int
    let launchName: String
    let liftOffTime: String
    let missionOutcome: Outcome
}

let launches: [Launch] = [
    Launch(launchID: 1, launchName: "KPLO", liftOffTime: "2022-08-14T23:08:00+0000", missionOutcome: .success),
    Launch(launchID: 2, launchName: "DSCOVR", liftOffTime: "2022-08-11T23:08:00+0000", missionOutcome: .success),
    Launch(launchID: 3, launchName: "TESS", liftOffTime: "2022-08-03T23:08:00+0000", missionOutcome: .failure),
    
]
