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

public class CustomerLoader {
    @Published var allCutomers = [Customer]()
    
    init() {
        if let fileLocation = Bundle.main.url(forResource: "customer", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Customer].self, from: data)
                
                self.allCutomers = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
