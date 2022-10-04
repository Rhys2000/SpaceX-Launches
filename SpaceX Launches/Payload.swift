//
//  Payload.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/25/22.
//

import Foundation

struct Payload: Codable {
    let cosparID: Int
    let internationalCode: String
    let name: String
    let fullname: String
    let nationAbbreviation: String
    let payloadType: String
    let customer: [String]
    let contractor: String
    let launchDate: String
    let configuration: String
    let propulsion: String
    let mass: Double
    let description: [String]
    let orbit: [Double]
}

//turn payload type into an enumerator
