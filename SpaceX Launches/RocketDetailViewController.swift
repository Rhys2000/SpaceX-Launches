//
//  RocketDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/21/22.
//

import UIKit

class RocketDetailViewController: UIViewController {
    
    static let identifier = "RocketDetailViewController"
    
    var currentRocket = Rocket(rawValue: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Rocket" + currentRocket!.rawValue
    }
}
