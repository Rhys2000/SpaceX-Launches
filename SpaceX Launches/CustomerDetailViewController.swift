//
//  CustomerDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/20/22.
//

import UIKit

class CustomerDetailViewController: UIViewController {
    
    static let identifier = "CustomerDetailViewController"
    
    var customer = Customer(abbreviatedCustomerName: "", customerWikipediaPageLink: "", customerWebsiteLink: "", customerLogoColors: [""])

    override func viewDidLoad() {
        super.viewDidLoad()

        title = customer.abbreviatedCustomerName
    }

}
