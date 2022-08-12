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
    case failure = "Failure"
    case upcoming = "Upcoming"
    case unknown = "Unknown"
}

struct Launch: Codable {
    let launchID: Int
    let launchName: String
    let alternativeLaunchName: String
    let abbreviatedLaunchName: String
    let liftOffTime: String
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
