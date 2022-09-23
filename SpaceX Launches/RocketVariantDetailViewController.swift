//
//  RocketVariantDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/21/22.
//

import UIKit

class RocketVariantDetailViewController: UIViewController {
    
    static let identifier = "RocketVariantDetailViewController"
    
    var currentRocketVariant = BoosterVariant(rawValue: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Rocket Variant" + currentRocketVariant!.rawValue
    }
}
