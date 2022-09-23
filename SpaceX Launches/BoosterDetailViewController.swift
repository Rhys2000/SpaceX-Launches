//
//  BoosterDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/22/22.
//

import UIKit

class BoosterDetailViewController: UIViewController {
    
    static let identifier = "BoosterDetailViewController"
    
    var currentBooster = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Booster Controller" + currentBooster
    }
}
