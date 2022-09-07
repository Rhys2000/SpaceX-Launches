//
//  SupportVesselDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/4/22.
//

import UIKit

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var customURL: String?
}

class SupportVesselDetailViewController: UIViewController {
    
    static let identifier = "SupportVesselDetailViewController"
    
    var currentVessel = SupportVessel(supportVesselName: "", supportVesselFormerNames: [""], internationalMaritimeOrganizationNumber: 0, supportVesselOwner: "", ownerWebsite: "", supportVesselOperator: "", operatorWebsite: "", supportVesselType: "", countryOfRegistration: "", portOfCalling: "", yearBuilt: 0, hullLength: 0, hullWidth: 0, yearJoinedSupportFleet: 0, yearLeftSupportFleet: 0, isActive: "", photographerCredit: "", marineFleetLink: "")
    
    private let headerPhoto = UIImageView()
    private let scrollView = UIScrollView()
    private let detailViewStatiticsSectionLabel = UILabel()
    private let ownerLabel = UILabel()
    private let ownerLabelData = UILabel()
    private let operatorLabel = UILabel()
    private let operatorLabelData = UILabel()
    private let previousNamesLabel = UILabel()
    private let previousNamesLabelData = UILabel()
    private let imoLabel = UILabel()
    private let imoLabelData = UILabel()
    private let yearBuiltLabel = UILabel()
    private let yearBuiltLabelData = UILabel()
    private let vesselTypeLabel = UILabel()
    private let vesselTypeLabelData = UILabel()
    private let hullLengthLabel = UILabel()
    private let hullLengthLabelData = UILabel()
    private let hullWidthLabel = UILabel()
    private let hullWidthLabelData = UILabel()
    private let homePortLabel = UILabel()
    private let homePortLabelData = UILabel()
    private let marineFleetLabel = UILabel()
    private let marineFleetLabelData = UILabel()

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
        scrollView.addSubview(detailViewStatiticsSectionLabel)
        
        //owner
        ownerLabel.text = "Owner: "
        ownerLabel.font = .boldSystemFont(ofSize: ownerLabel.font.pointSize)
        ownerLabel.sizeToFit()
        scrollView.addSubview(ownerLabel)
        
        //ownerData
        ownerLabelData.text = "  " + currentVessel.supportVesselOwner + "  "
        ownerLabelData.isUserInteractionEnabled = true
        ownerLabelData.sizeToFit()
        ownerLabelData.layer.cornerRadius = 10
        ownerLabelData.layer.borderWidth = 1
        ownerLabelData.layer.borderColor = UIColor.white.cgColor
        
        let ownerLabelTapGesture = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        ownerLabelTapGesture.customURL = currentVessel.ownerWebsite
        ownerLabelData.addGestureRecognizer(ownerLabelTapGesture)
        
        scrollView.addSubview(ownerLabelData)
        
        //operatorLabel
        operatorLabel.text = "Operator: "
        operatorLabel.font = .boldSystemFont(ofSize: operatorLabel.font.pointSize)
        operatorLabel.sizeToFit()
        scrollView.addSubview(operatorLabel)
        
        //operatorLabelData
        operatorLabelData.text = "  " + currentVessel.supportVesselOperator + "  "
        operatorLabelData.isUserInteractionEnabled = true
        operatorLabelData.sizeToFit()
        operatorLabelData.layer.cornerRadius = 10
        operatorLabelData.layer.borderWidth = 1
        operatorLabelData.layer.borderColor = UIColor.white.cgColor
        
        let operatorLabelTapGesture = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        operatorLabelTapGesture.customURL = currentVessel.operatorWebsite
        operatorLabelData.addGestureRecognizer(operatorLabelTapGesture)
        
        scrollView.addSubview(operatorLabelData)
        
        //imoLabel
        imoLabel.text = ""
        if(String(currentVessel.internationalMaritimeOrganizationNumber).count == 9) {
            imoLabel.text! += "MMSI Number: "
        } else {
            imoLabel.text! += "IMO Number: "
        }
        imoLabel.font = .boldSystemFont(ofSize: imoLabel.font.pointSize)
        imoLabel.sizeToFit()
        scrollView.addSubview(imoLabel)
        
        //imoLabelData
        imoLabelData.text = String(currentVessel.internationalMaritimeOrganizationNumber)
        imoLabelData.sizeToFit()
        scrollView.addSubview(imoLabelData)
        
        //previousNamesLabel
        previousNamesLabel.text = "Previous Names: "
        previousNamesLabel.font = .boldSystemFont(ofSize: previousNamesLabel.font.pointSize)
        previousNamesLabel.sizeToFit()
        scrollView.addSubview(previousNamesLabel)
        
        //yearBuiltLabel
        yearBuiltLabel.text = "Year Built:"
        yearBuiltLabel.font = .boldSystemFont(ofSize: yearBuiltLabel.font.pointSize)
        yearBuiltLabel.sizeToFit()
        scrollView.addSubview(yearBuiltLabel)
        
        //yearBuiltDataLabel
        yearBuiltLabelData.text = " " + String(currentVessel.yearBuilt)
        yearBuiltLabelData.sizeToFit()
        scrollView.addSubview(yearBuiltLabelData)
        
        //vesselTypeLabel
        vesselTypeLabel.text = "Vessel Type:"
        vesselTypeLabel.font = .boldSystemFont(ofSize: vesselTypeLabel.font.pointSize)
        vesselTypeLabel.sizeToFit()
        scrollView.addSubview(vesselTypeLabel)
        
        //vesselTypeLabelData
        vesselTypeLabelData.text = " " + currentVessel.supportVesselType
        vesselTypeLabelData.sizeToFit()
        scrollView.addSubview(vesselTypeLabelData)
        
        //hullLengthLabel
        hullLengthLabel.text = "Hull Length:"
        hullLengthLabel.font = .boldSystemFont(ofSize: hullLengthLabel.font.pointSize)
        hullLengthLabel.sizeToFit()
        scrollView.addSubview(hullLengthLabel)
        
        //hullLengthLabelData
        hullLengthLabelData.text = " " + String(currentVessel.hullLength) + " meters"
        hullLengthLabelData.sizeToFit()
        scrollView.addSubview(hullLengthLabelData)
        
        //hullWidthLabel
        hullWidthLabel.text = "Hull Width:"
        hullWidthLabel.font = .boldSystemFont(ofSize: hullWidthLabel.font.pointSize)
        hullWidthLabel.sizeToFit()
        scrollView.addSubview(hullWidthLabel)
        
        //hullWidthLabelData
        hullWidthLabelData.text = " " + String(currentVessel.hullWidth) + " meters"
        hullWidthLabelData.sizeToFit()
        scrollView.addSubview(hullWidthLabelData)
        
        //homePortLabel
        homePortLabel.text = "Home Port: "
        homePortLabel.font = .boldSystemFont(ofSize: homePortLabel.font.pointSize)
        homePortLabel.sizeToFit()
        scrollView.addSubview(homePortLabel)
        
        //homePortLabelData
        homePortLabelData.text = "  " + currentVessel.portOfCalling + "  "
        homePortLabelData.isUserInteractionEnabled = true
        homePortLabelData.sizeToFit()
        homePortLabelData.layer.cornerRadius = 10
        homePortLabelData.layer.borderWidth = 1
        homePortLabelData.layer.borderColor = UIColor.white.cgColor
        
        let homePortLabelTapGesture = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        homePortLabelTapGesture.customURL = "http://maps.apple.com/"// + currentVessel.portOfCalling
        homePortLabelData.addGestureRecognizer(homePortLabelTapGesture)
        
        scrollView.addSubview(homePortLabelData)
        
        //previousNamessLabelData
        previousNamesLabelData.text = ""
        if(currentVessel.supportVesselFormerNames.count == 1) {
            previousNamesLabelData.text! += currentVessel.supportVesselFormerNames[0]
        } else if (currentVessel.supportVesselFormerNames.count == 2) {
            previousNamesLabelData.text! += currentVessel.supportVesselFormerNames[0] + " and " + currentVessel.supportVesselFormerNames[1]
        } else {
            for name in currentVessel.supportVesselFormerNames {
                if(name == currentVessel.supportVesselFormerNames.last) {
                    previousNamesLabelData.text! += "and " + name
                } else {
                    previousNamesLabelData.text! += name + ", \n"
                }
            }
        }
        previousNamesLabelData.numberOfLines = 0
        scrollView.addSubview(previousNamesLabelData)
        
        //marineFleetLabel
        marineFleetLabel.text = "Marine Fleet Page: "
        marineFleetLabel.font = .boldSystemFont(ofSize: marineFleetLabel.font.pointSize)
        marineFleetLabel.sizeToFit()
        scrollView.addSubview(marineFleetLabel)
        
        //marineFleetLabelData
        marineFleetLabelData.text = "  " + currentVessel.supportVesselName + "  "
        marineFleetLabelData.isUserInteractionEnabled = true
        marineFleetLabelData.sizeToFit()
        marineFleetLabelData.layer.cornerRadius = 10
        marineFleetLabelData.layer.borderWidth = 1
        marineFleetLabelData.layer.borderColor = UIColor.white.cgColor
        
        let marineFleetLabelTapGesture = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        marineFleetLabelTapGesture.customURL = currentVessel.marineFleetLink
        marineFleetLabelData.addGestureRecognizer(marineFleetLabelTapGesture)
        
        scrollView.addSubview(marineFleetLabelData)
        
//        let window = UIApplication.shared.windows.first
//        print(window?.safeAreaInsets)
//        print(self.navigationController?.navigationBar.frame.height)
        //navigationController?.navigationBar.backgroundColor = .blue
        //print(tabBarController?.tabBar.frame.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //scrollView
        scrollView.frame = CGRect(x: 0, y: 143, width: view.bounds.width, height: view.bounds
            .height - 143 - 87)
        
        //headerPhoto
        headerPhoto.frame = CGRect(x: 10, y: 10, width: scrollView.bounds.width - 20, height: 200)
        
        //Statictics Section Label
        detailViewStatiticsSectionLabel.frame = CGRect(x: 10, y: headerPhoto.frame.maxY + 10, width: scrollView.bounds.width - 20, height: detailViewStatiticsSectionLabel.bounds.height)
        
        //Owner Labels
        ownerLabel.frame = CGRect(x: (scrollView.bounds.width - (ownerLabel.frame.width + ownerLabelData.frame.width)) / 2, y: detailViewStatiticsSectionLabel.frame.maxY + 10, width: ownerLabel.frame.width, height: ownerLabel.frame.height)
        ownerLabelData.frame = CGRect(x: ownerLabel.frame.maxX, y: detailViewStatiticsSectionLabel.frame.maxY + 10, width: ownerLabelData.frame.width, height: ownerLabelData.frame.height)
        
        //Operator Labels
        operatorLabel.frame = CGRect(x: (scrollView.bounds.width - (operatorLabel.frame.width + operatorLabelData.frame.width)) / 2, y: ownerLabel.frame.maxY + 5, width: operatorLabel.frame.width, height: operatorLabel.frame.height)
        operatorLabelData.frame = CGRect(x: operatorLabel.frame.maxX, y: ownerLabel.frame.maxY + 5, width: operatorLabelData.frame.width, height: operatorLabelData.frame.height)
        
        //Marine Organization Numbr Labels
        imoLabel.frame = CGRect(x: (scrollView.bounds.width - (imoLabel.frame.width + imoLabelData.frame.width)) / 2, y: operatorLabel.frame.maxY + 5, width: imoLabel.frame.width, height: imoLabel.frame.height)
        imoLabelData.frame = CGRect(x: imoLabel.frame.maxX, y: operatorLabel.frame.maxY + 5, width: imoLabelData.frame.width, height: imoLabelData.frame.height)
        
        //Year Built Labels
        yearBuiltLabel.frame = CGRect(x: (scrollView.bounds.width - (yearBuiltLabel.frame.width + yearBuiltLabelData.frame.width)) / 2, y: imoLabel.frame.maxY + 5, width: yearBuiltLabel.frame.width, height: yearBuiltLabel.frame.height)
        yearBuiltLabelData.frame = CGRect(x: yearBuiltLabel.frame.maxX, y: imoLabel.frame.maxY + 5, width: yearBuiltLabelData.frame.width, height: yearBuiltLabelData.frame.height)
        
        //Vessel Type Labels
        vesselTypeLabel.frame = CGRect(x: (scrollView.bounds.width - (vesselTypeLabel.frame.width + vesselTypeLabelData.frame.width)) / 2, y: yearBuiltLabel.frame.maxY + 5, width: vesselTypeLabel.frame.width, height: vesselTypeLabel.frame.height)
        vesselTypeLabelData.frame = CGRect(x: vesselTypeLabel.frame.maxX, y: yearBuiltLabel.frame.maxY + 5, width: vesselTypeLabelData.frame.width, height: vesselTypeLabelData.frame.height)
        
        //Hull Length Labels
        hullLengthLabel.frame = CGRect(x: (scrollView.bounds.width - (hullLengthLabel.frame.width + hullLengthLabelData.frame.width)) / 2, y: vesselTypeLabel.frame.maxY + 5, width: hullLengthLabel.frame.width, height: hullLengthLabel.frame.height)
        hullLengthLabelData.frame = CGRect(x: hullLengthLabel.frame.maxX, y: vesselTypeLabel.frame.maxY + 5, width: hullLengthLabelData.frame.width, height: hullLengthLabelData.frame.height)
        
        //Hull Width Labels
        hullWidthLabel.frame = CGRect(x: (scrollView.bounds.width - (hullWidthLabel.frame.width + hullWidthLabelData.frame.width)) / 2, y: hullLengthLabel.frame.maxY + 5, width: hullWidthLabel.frame.width, height: hullWidthLabel.frame.height)
        hullWidthLabelData.frame = CGRect(x: hullWidthLabel.frame.maxX, y: hullLengthLabel.frame.maxY + 5, width: hullWidthLabelData.frame.width, height: hullWidthLabelData.frame.height)
        
        //Home Port Labels
        homePortLabel.frame = CGRect(x: (scrollView.bounds.width - (homePortLabel.frame.width + homePortLabelData.frame.width)) / 2, y: hullWidthLabel.frame.maxY + 5, width: homePortLabel.frame.width, height: homePortLabel.frame.height)
        homePortLabelData.frame = CGRect(x: homePortLabel.frame.maxX, y: hullWidthLabel.frame.maxY + 5, width: homePortLabelData.frame.width, height: homePortLabelData.frame.height)
        
        //Previous Names Labels
        let previousNamesLabelDataSize = updateLabelFrame(for: previousNamesLabelData, using: previousNamesLabel)
        previousNamesLabel.frame = CGRect(x: (scrollView.bounds.width - (previousNamesLabel.frame.width + previousNamesLabelDataSize.width)) / 2, y: homePortLabel.frame.maxY + 5, width: previousNamesLabel.frame.width, height: previousNamesLabel.frame.height)
        previousNamesLabelData.frame = CGRect(x: previousNamesLabel.frame.maxX, y: homePortLabel.frame.maxY + 5, width: previousNamesLabelDataSize.width, height: previousNamesLabelDataSize.height)
        
        marineFleetLabel.frame = CGRect(x: (scrollView.bounds.width - (marineFleetLabel.frame.width + marineFleetLabelData.frame.width)) / 2, y: previousNamesLabelData.frame.maxY + 5, width: marineFleetLabel.frame.width, height: marineFleetLabel.frame.height)
        marineFleetLabelData.frame = CGRect(x: marineFleetLabel.frame.maxX, y: previousNamesLabelData.frame.maxY + 5, width: marineFleetLabelData.frame.width, height: marineFleetLabelData.frame.height)
    }
    
    func updateLabelFrame(for dataLabel: UILabel, using label: UILabel) -> CGSize {
        let maxSize = CGSize(width: view.bounds.width - 20 - label.bounds.width, height: 1000)
        return dataLabel.sizeThatFits(maxSize)
    }
    
    @objc func linkTap(sender: CustomTapGestureRecognizer) {
        if let url = URL(string: sender.customURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
