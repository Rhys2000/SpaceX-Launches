//
//  SupportVesselDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/4/22.
//

import UIKit

class SupportVesselDetailViewController: UIViewController {
    
    static let identifier = "SupportVesselDetailViewController"
    
    var currentVessel = SupportVessel(supportVesselName: "", supportVesselFormerNames: [""], internationalMaritimeOrganizationNumber: 0, supportVesselOwner: "", supportVesselOperator: "", supportVesselType: "", countryOfRegistration: "", portOfCalling: "", yearBuilt: 0, hullLength: 0, hullWidth: 0, yearJoinedSupportFleet: 0, yearLeftSupportFleet: 0, isActive: "", photographerCredit: "")
    
    private let headerPhoto = UIImageView()
    private let scrollView = UIScrollView()
    private let detailViewStatiticsSectionLabel = UILabel()
    private let ownerLabel = UILabel()
    private let ownerLabelData = UILabel()
    private let operatorLabel = UILabel()
    private let operatorLabelData = UILabel()
    private let previousNamesLabel = UILabel()
    private let previousNamesLabelData = UILabel()
    private let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Large Title
        title = currentVessel.supportVesselName
        
        //ScrollView
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1500)
        view.addSubview(scrollView)
        
        //SupportVesselHeaderImage image settings
        headerPhoto.image = UIImage(named: currentVessel.supportVesselName.replacingOccurrences(of: " ", with: ""))
        headerPhoto.contentMode = .scaleAspectFill
        headerPhoto.clipsToBounds = true
        headerPhoto.layer.cornerRadius = 10.0
        scrollView.addSubview(headerPhoto)
        
        //detailViewStatisticsSection label settings
        detailViewStatiticsSectionLabel.text = "Vital Statistics"
        detailViewStatiticsSectionLabel.textAlignment = .center
        detailViewStatiticsSectionLabel.font = .boldSystemFont(ofSize: 28)
        detailViewStatiticsSectionLabel.sizeToFit()
        detailViewStatiticsSectionLabel.layoutIfNeeded()
        scrollView.addSubview(detailViewStatiticsSectionLabel)
        
        //owner
        ownerLabel.text = "Owner:"
        ownerLabel.font = .boldSystemFont(ofSize: ownerLabel.font.pointSize)
        ownerLabel.sizeToFit()
        ownerLabel.layoutIfNeeded()
        scrollView.addSubview(ownerLabel)
        
        //ownerData
        ownerLabelData.text = " " + currentVessel.supportVesselOwner
        ownerLabelData.sizeToFit()
        ownerLabelData.layoutIfNeeded()
        scrollView.addSubview(ownerLabelData)
        
        //operatorLabel
        operatorLabel.text = "Operator:"
        operatorLabel.font = .boldSystemFont(ofSize: operatorLabel.font.pointSize)
        operatorLabel.sizeToFit()
        operatorLabel.layoutIfNeeded()
        scrollView.addSubview(operatorLabel)
        
        //operatorLabelData
        operatorLabelData.text = " " + currentVessel.supportVesselOperator
        operatorLabelData.sizeToFit()
        operatorLabelData.layoutIfNeeded()
        scrollView.addSubview(operatorLabelData)
        
        //previousNamesLabel
        previousNamesLabel.text = "Previous Names:"
        previousNamesLabel.font = .boldSystemFont(ofSize: previousNamesLabel.font.pointSize)
        previousNamesLabel.sizeToFit()
        previousNamesLabel.layoutIfNeeded()
        scrollView.addSubview(previousNamesLabel)
        
        //previousNamessLabelData
        previousNamesLabelData.text = " "
        for name in currentVessel.supportVesselFormerNames {
            previousNamesLabelData.text! += name + ", "
        }
        previousNamesLabelData.lineBreakMode = .byWordWrapping
        previousNamesLabelData.numberOfLines = 2
        previousNamesLabelData.layer.masksToBounds = true
        previousNamesLabelData.sizeToFit()
        previousNamesLabelData.layoutIfNeeded()
        scrollView.addSubview(previousNamesLabelData)
        
        
//        let window = UIApplication.shared.windows.first
//        print(window?.safeAreaInsets)
//        print(self.navigationController?.navigationBar.frame.height)
        //navigationController?.navigationBar.backgroundColor = .blue
        //print(tabBarController?.tabBar.frame.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 143, width: view.bounds.width, height: view.bounds
            .height - 143 - 87)
        headerPhoto.frame = CGRect(x: 10, y: 10, width: scrollView.bounds.width - 20, height: 200)
        detailViewStatiticsSectionLabel.frame = CGRect(x: 10, y: headerPhoto.frame.maxY + 10, width: scrollView.bounds.width - 20, height: detailViewStatiticsSectionLabel.bounds.height)
        ownerLabel.frame = CGRect(x: (scrollView.bounds.width - (ownerLabel.frame.width + ownerLabelData.frame.width)) / 2, y: detailViewStatiticsSectionLabel.frame.maxY + 10, width: ownerLabel.frame.width, height: ownerLabel.frame.height)
        ownerLabelData.frame = CGRect(x: ownerLabel.frame.maxX, y: detailViewStatiticsSectionLabel.frame.maxY + 10, width: ownerLabelData.frame.width, height: ownerLabelData.frame.height)
        operatorLabel.frame = CGRect(x: (scrollView.bounds.width - (operatorLabel.frame.width + operatorLabelData.frame.width)) / 2, y: ownerLabel.frame.maxY + 5, width: operatorLabel.frame.width, height: operatorLabel.frame.height)
        operatorLabelData.frame = CGRect(x: operatorLabel.frame.maxX, y: ownerLabel.frame.maxY + 5, width: operatorLabelData.frame.width, height: operatorLabelData.frame.height)
        previousNamesLabel.frame = CGRect(x: (scrollView.bounds.width - (previousNamesLabel.frame.width + previousNamesLabelData.frame.width)) / 2, y: operatorLabel.frame.maxY + 5, width: previousNamesLabel.frame.width, height: previousNamesLabel.frame.height)
        previousNamesLabelData.frame = CGRect(x: previousNamesLabel.frame.maxX, y: operatorLabel.frame.maxY + 5, width: previousNamesLabelData.frame.width, height: previousNamesLabelData.frame.height)
    }
}
