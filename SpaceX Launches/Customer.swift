//
//  Customer.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/14/22.
//

import Foundation
import UIKit

struct Customer: Codable {
    var customerName: String = ""
    let abbreviatedCustomerName: String
    let customerWikipediaPageLink: String
    let customerWebsiteLink: String
    let customerLogoColors: [String]
}
