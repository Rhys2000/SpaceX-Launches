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
    
    var currentVessel = SupportVessel(supportVesselName: "", supportVesselFormerNames: [""], supportVesselDescription: [""], internationalMaritimeOrganizationNumber: 0, supportVesselOwner: "", ownerWebsite: "", supportVesselOperator: "", operatorWebsite: "", supportVesselType: "", countryOfRegistration: "", portOfCalling: "", portOfCallingLatitude: 0, portOfCallingLongitude: 0, yearBuilt: 0, hullLength: 0, hullWidth: 0, yearJoinedSupportFleet: 0, yearLeftSupportFleet: 0, isActive: "", photographerCredit: "", marineFleetLink: "")
    
    var launchesUsingSupportVessel = [Launch]()
    
    private let scrollView = UIScrollView()
    private let headerPhotoImageView = UIImageView()
    private let detailViewAboutSectionBackgroundView = UIView()
    private let detailViewAboutSectionLabel = UILabel()
    private let aboutSectionData = UILabel()
    private let aboutSectionLabelButton = UILabel()
    private let aboutSectionButtonImage = UIImageView()
    private let detailViewStatisticsSectionBackgroundView = UIView()
    private let detailViewStatisticsSectionLabel = UILabel()
    private let ownerLabel = UILabel()
    private let ownerLabelData = UILabel()
    private let operatorLabel = UILabel()
    private let operatorLabelData = UILabel()
    private let vesselTypeLabel = UILabel()
    private let vesselTypeLabelData = UILabel()
    private let yearsInFleetLabel = UILabel()
    private let yearsInFleetLabelData = UILabel()
    private let previousNamesLabel = UILabel()
    private let previousNamesLabelData = UILabel()
    private let yearBuiltLabel = UILabel()
    private let yearBuiltLabelData = UILabel()
    private let imoNumberLabel = UILabel()
    private let imoNumberLabelData = UILabel()
    private let homePortLabel = UILabel()
    private let homePortLabelData = UILabel()
    private let hullLengthLabel = UILabel()
    private let hullLengthLabelData = UILabel()
    private let hullWidthLabel = UILabel()
    private let hullWidthLabelData = UILabel()
    private let marineFleetLabel = UILabel()
    private let marineFleetLabelData = UILabel()
    private let detailViewMilestonesSectionBackgroundView = UIView()
    private let detailViewMilestonesSectionLabel = UILabel()
    private let missionsDeployedLabel = UILabel()
    private let missionRoleLabel = UILabel()
    private let missionInvolementTimelineLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentVessel.supportVesselName
        
        for launch in LaunchLoader().allLaunches {
            if(launch.missionSupportShips.contains(currentVessel.supportVesselName)) {
                launchesUsingSupportVessel.append(launch)
            }
        }

        view.addSubview(scrollView)
        
        headerPhotoImageView.image = UIImage(named: currentVessel.supportVesselName.replacingOccurrences(of: " ", with: ""))
        headerPhotoImageView.contentMode = .scaleAspectFill
        headerPhotoImageView.clipsToBounds = true
        headerPhotoImageView.layer.cornerRadius = 10.0
        headerPhotoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(headerPhotoImageView)
        
        detailViewAboutSectionBackgroundView.backgroundColor = .gray
        detailViewAboutSectionBackgroundView.layer.cornerRadius = 10.0
        detailViewAboutSectionBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        scrollView.addSubview(detailViewAboutSectionBackgroundView)
        
        detailViewAboutSectionLabel.text = "About " + currentVessel.supportVesselName
        detailViewAboutSectionLabel.font = .boldSystemFont(ofSize: 24)
        detailViewAboutSectionLabel.textAlignment = .center
        detailViewAboutSectionLabel.sizeToFit()
        detailViewAboutSectionLabel.adjustsFontSizeToFitWidth = true
        detailViewAboutSectionBackgroundView.addSubview(detailViewAboutSectionLabel)
        
        aboutSectionData.text = ""
        if(currentVessel.supportVesselDescription.count >= 2) {
            aboutSectionData.text = currentVessel.supportVesselDescription[0] + "\n\n" + currentVessel.supportVesselDescription[1]
        } else {
            aboutSectionData.text = currentVessel.supportVesselDescription[0]
        }
        aboutSectionData.numberOfLines = 0
        detailViewAboutSectionBackgroundView.addSubview(aboutSectionData)
        
        if(currentVessel.supportVesselDescription.count > 2) {
            aboutSectionLabelButton.text = "  Read More  "
            aboutSectionLabelButton.font = .systemFont(ofSize: 20)
            aboutSectionLabelButton.isUserInteractionEnabled = true
            aboutSectionLabelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushDetailViewAboutViewController)))
            aboutSectionLabelButton.sizeToFit()
            aboutSectionLabelButton.layer.cornerRadius = 10.0
            aboutSectionLabelButton.layer.borderWidth = 1
            aboutSectionLabelButton.layer.borderColor = UIColor.white.cgColor
            detailViewAboutSectionBackgroundView.addSubview(aboutSectionLabelButton)
    
            aboutSectionButtonImage.image = UIImage(systemName: "text.book.closed")
            aboutSectionButtonImage.tintColor = .white
            aboutSectionButtonImage.frame.size = CGSize(width: aboutSectionLabelButton.frame.height, height: aboutSectionLabelButton.frame.height)
            detailViewAboutSectionBackgroundView.addSubview(aboutSectionButtonImage)
        }
        
        detailViewStatisticsSectionBackgroundView.backgroundColor = .gray
        detailViewStatisticsSectionBackgroundView.layer.cornerRadius = 10.0
        scrollView.addSubview(detailViewStatisticsSectionBackgroundView)
        
        detailViewStatisticsSectionLabel.text = "Vital Statistics"
        detailViewStatisticsSectionLabel.font = .boldSystemFont(ofSize: 24)
        detailViewStatisticsSectionLabel.textAlignment = .center
        detailViewStatisticsSectionLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(detailViewStatisticsSectionLabel)
        
        ownerLabel.text = "Owner Link: "
        ownerLabel.font = .boldSystemFont(ofSize: ownerLabel.font.pointSize)
        ownerLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(ownerLabel)

        ownerLabelData.text = " " + currentVessel.supportVesselOwner + " "
        ownerLabelData.isUserInteractionEnabled = true
        let ownerLink = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        ownerLink.customURL = currentVessel.ownerWebsite
        ownerLabelData.addGestureRecognizer(ownerLink)
        ownerLabelData.sizeToFit()
        ownerLabelData.layer.cornerRadius = 10.0
        ownerLabelData.layer.borderWidth = 1
        ownerLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewStatisticsSectionBackgroundView.addSubview(ownerLabelData)

        operatorLabel.text = "Operator Link: "
        operatorLabel.font = .boldSystemFont(ofSize: operatorLabel.font.pointSize)
        operatorLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(operatorLabel)

        operatorLabelData.text = " " + currentVessel.supportVesselOperator + " "
        operatorLabelData.isUserInteractionEnabled = true
        let operatorLink = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        operatorLink.customURL = currentVessel.operatorWebsite
        operatorLabelData.addGestureRecognizer(operatorLink)
        operatorLabelData.sizeToFit()
        operatorLabelData.layer.cornerRadius = 10.0
        operatorLabelData.layer.borderWidth = 1
        operatorLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewStatisticsSectionBackgroundView.addSubview(operatorLabelData)

        vesselTypeLabel.text = "Vessel Type:"
        vesselTypeLabel.font = .boldSystemFont(ofSize: vesselTypeLabel.font.pointSize)
        vesselTypeLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(vesselTypeLabel)

        vesselTypeLabelData.text = " " + currentVessel.supportVesselType
        vesselTypeLabelData.adjustsFontSizeToFitWidth = true
        detailViewStatisticsSectionBackgroundView.addSubview(vesselTypeLabelData)

        yearsInFleetLabel.text = "Service Record:"
        yearsInFleetLabel.font = .boldSystemFont(ofSize: yearsInFleetLabel.font.pointSize)
        yearsInFleetLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(yearsInFleetLabel)

        yearsInFleetLabelData.text = " " + String(currentVessel.yearJoinedSupportFleet)
        if(currentVessel.yearLeftSupportFleet == 0) {
            yearsInFleetLabelData.text! += " - Present"
        } else if(currentVessel.yearJoinedSupportFleet != currentVessel.yearLeftSupportFleet) {
            yearsInFleetLabelData.text! += " - " + String(currentVessel.yearLeftSupportFleet)
        }
        yearsInFleetLabelData.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(yearsInFleetLabelData)

        if(currentVessel.supportVesselFormerNames.count >= 1 && currentVessel.supportVesselFormerNames[0] != "") {

            previousNamesLabel.text = "Previous Names: "
            previousNamesLabel.font = .boldSystemFont(ofSize: previousNamesLabel.font.pointSize)
            previousNamesLabel.sizeToFit()
            detailViewStatisticsSectionBackgroundView.addSubview(previousNamesLabel)

            if(currentVessel.supportVesselFormerNames.count == 1) {
                previousNamesLabelData.text = currentVessel.supportVesselFormerNames[0]
            } else if(currentVessel.supportVesselFormerNames.count == 2) {
                previousNamesLabelData.text = currentVessel.supportVesselFormerNames[0] + " and " + currentVessel.supportVesselFormerNames[1]
            } else {
                previousNamesLabelData.text = ""
                for name in currentVessel.supportVesselFormerNames {
                    if(name == currentVessel.supportVesselFormerNames.last) {
                        previousNamesLabelData.text! += " and " + name
                    } else {
                        previousNamesLabelData.text! += name + ", "
                    }
                }
            }
            previousNamesLabelData.numberOfLines = 0
            previousNamesLabelData.lineBreakMode = .byWordWrapping
            detailViewStatisticsSectionBackgroundView.addSubview(previousNamesLabelData)
        }

        yearBuiltLabel.text = "Year Built:"
        yearBuiltLabel.font = .boldSystemFont(ofSize: yearBuiltLabel.font.pointSize)
        yearBuiltLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(yearBuiltLabel)

        yearBuiltLabelData.text = " " + String(currentVessel.yearBuilt)
        yearBuiltLabelData.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(yearBuiltLabelData)

        if(String(currentVessel.internationalMaritimeOrganizationNumber).count == 7) {
            imoNumberLabel.text = "IMO Number:"
        } else {
            imoNumberLabel.text = "MMSI Number:"
        }
        imoNumberLabel.font = .boldSystemFont(ofSize: imoNumberLabel.font.pointSize)
        imoNumberLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(imoNumberLabel)

        imoNumberLabelData.text = " " + String(currentVessel.internationalMaritimeOrganizationNumber)
        imoNumberLabelData.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(imoNumberLabelData)

        homePortLabel.text = "Home Port: "
        homePortLabel.font = .boldSystemFont(ofSize: homePortLabel.font.pointSize)
        homePortLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(homePortLabel)

        homePortLabelData.text = " " + currentVessel.portOfCalling + " "
        homePortLabelData.isUserInteractionEnabled = true
        homePortLabelData.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushHomePortViewController)))
        homePortLabelData.sizeToFit()
        homePortLabelData.layer.cornerRadius = 10.0
        homePortLabelData.layer.borderWidth = 1
        homePortLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewStatisticsSectionBackgroundView.addSubview(homePortLabelData)

        hullLengthLabel.text = "Hull Length:"
        hullLengthLabel.font = .boldSystemFont(ofSize: hullLengthLabel.font.pointSize)
        hullLengthLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(hullLengthLabel)

        hullLengthLabelData.text = " " + String(currentVessel.hullLength) + " meters"
        hullLengthLabelData.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(hullLengthLabelData)

        hullWidthLabel.text = "Hull Width:"
        hullWidthLabel.font = .boldSystemFont(ofSize: hullWidthLabel.font.pointSize)
        hullWidthLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(hullWidthLabel)

        hullWidthLabelData.text = " " + String(currentVessel.hullWidth) + " meters"
        hullWidthLabelData.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(hullWidthLabelData)

        marineFleetLabel.text = "Marine Fleet Link: "
        marineFleetLabel.font = .boldSystemFont(ofSize: operatorLabel.font.pointSize)
        marineFleetLabel.sizeToFit()
        detailViewStatisticsSectionBackgroundView.addSubview(marineFleetLabel)

        marineFleetLabelData.text = " " + currentVessel.supportVesselName + " "
        marineFleetLabelData.isUserInteractionEnabled = true
        let marineFleetLink = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        marineFleetLink.customURL = currentVessel.marineFleetLink
        marineFleetLabelData.addGestureRecognizer(marineFleetLink)
        marineFleetLabelData.sizeToFit()
        marineFleetLabelData.layer.cornerRadius = 10.0
        marineFleetLabelData.layer.borderWidth = 1
        marineFleetLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewStatisticsSectionBackgroundView.addSubview(marineFleetLabelData)
        
        detailViewMilestonesSectionBackgroundView.backgroundColor = .gray
        detailViewMilestonesSectionBackgroundView.layer.cornerRadius = 10.0
        scrollView.addSubview(detailViewMilestonesSectionBackgroundView)

        detailViewMilestonesSectionLabel.text = "Vessel Milestones"
        detailViewMilestonesSectionLabel.font = .boldSystemFont(ofSize: 24)
        detailViewMilestonesSectionLabel.textAlignment = .center
        detailViewMilestonesSectionLabel.sizeToFit()
        detailViewMilestonesSectionBackgroundView.addSubview(detailViewMilestonesSectionLabel)
        
        missionsDeployedLabel.text = currentVessel.supportVesselName + " has been deployed for use on " + String(launchesUsingSupportVessel.count) + " SpaceX missions"
        missionsDeployedLabel.numberOfLines = 0
        detailViewMilestonesSectionBackgroundView.addSubview(missionsDeployedLabel)
        
        var individualVesselRoles = [String](), filteredIndividualVesselRoles = [String](), valuesOfVesselRoles = [Int](), vesselRoleDictionary = [String: Int]()
        for launch in launchesUsingSupportVessel {
            individualVesselRoles.append(launch.missionSupportShipRoles[launch.missionSupportShips.firstIndex(of: currentVessel.supportVesselName)!])
        }
        for role in individualVesselRoles {
            if(!filteredIndividualVesselRoles.contains(role)) {
                filteredIndividualVesselRoles.append(role)
                valuesOfVesselRoles.append(0)
            }
        }
        vesselRoleDictionary = Dictionary(uniqueKeysWithValues: zip(filteredIndividualVesselRoles, valuesOfVesselRoles))
        for role in individualVesselRoles {
            vesselRoleDictionary[role]! += 1
        }
        let tempKeys = [String](vesselRoleDictionary.keys)
        let tempValues = [Int](vesselRoleDictionary.values)
        missionRoleLabel.text = "\(currentVessel.supportVesselName) has been deployed in the role of "
        if(vesselRoleDictionary.count == 1) {
            missionRoleLabel.text! += "\(tempKeys[0].lowercased()) \(getProperWording(for: tempValues[0]))"
        } else if(vesselRoleDictionary.count == 2) {
            missionRoleLabel.text! += "\(tempKeys[0].lowercased()) \(getProperWording(for: tempValues[0])) and \(tempKeys[1].lowercased()) \(getProperWording(for: tempValues[1]))"
        } else {
           for (key, value) in vesselRoleDictionary {
               if(key == tempKeys.last) {
                   missionRoleLabel.text! += " and a \(key.lowercased()) \(getProperWording(for: value))"
                } else {
                    missionRoleLabel.text! += "\(key.lowercased()) \(getProperWording(for: value)), "
                }
            }
        }
        missionRoleLabel.numberOfLines = 0
        detailViewMilestonesSectionBackgroundView.addSubview(missionRoleLabel)
        
        print(launchesUsingSupportVessel[0].liftOffTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let firstDate = (launchesUsingSupportVessel.first?.liftOffTime)!
        let lastDate = (launchesUsingSupportVessel.last?.liftOffTime)!
        
        if(firstDate == lastDate) {
            missionInvolementTimelineLabel.text = currentVessel.supportVesselName + " was involved in a singular SpaceX mission, meaning it was part of the fleet for about 10 days"
        } else {
            var totalSeconds = Int((dateFormatter.date(from: lastDate)! - dateFormatter.date(from: firstDate)!))
            var timeSegments = [String]()
            missionInvolementTimelineLabel.text = "\(currentVessel.supportVesselName) has been used in the SpaceX fleet for "
            if(totalSeconds > 31536000) {
                timeSegments.append("\(totalSeconds / 31536000) years")
            }
            totalSeconds = totalSeconds % 31536000
            if(totalSeconds != 0) {
                timeSegments.append("\(totalSeconds / 86400) days")
            }
            totalSeconds = totalSeconds % 86400
            if(totalSeconds != 0) {
                timeSegments.append("\(totalSeconds / 3600) hours")
            }
            totalSeconds = totalSeconds % 3600
            if(totalSeconds != 0) {
                timeSegments.append("\(totalSeconds / 60) minutes")
            }
            totalSeconds = totalSeconds % 60
            if(totalSeconds != 0) {
                timeSegments.append("\(totalSeconds) seconds")
            }
            for element in timeSegments {
                if(element == timeSegments.last) {
                    missionInvolementTimelineLabel.text! += "and \(element) "
                } else {
                    missionInvolementTimelineLabel.text! += "\(element), "
                }
            }
            missionInvolementTimelineLabel.text! += "between its first and last missions"
        }
        missionInvolementTimelineLabel.numberOfLines = 0
        detailViewMilestonesSectionBackgroundView.addSubview(missionInvolementTimelineLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        headerPhotoImageView.frame = CGRect(x: 10, y: 0, width: scrollView.bounds.width - 20, height: 200) //Need to scale based on screen size
        
        detailViewAboutSectionBackgroundView.frame = CGRect(x: 10, y: headerPhotoImageView.frame.maxY, width: scrollView.bounds.width - 20, height: 300)
        
        detailViewAboutSectionLabel.frame = CGRect(x: 10, y: 5, width: detailViewAboutSectionBackgroundView.bounds.width - 20, height: detailViewAboutSectionLabel.frame.height)
        
        aboutSectionData.frame.size = updateFrameUsingBackgroundView(for: aboutSectionData, using: detailViewAboutSectionBackgroundView)
        aboutSectionData.frame.origin = CGPoint(x: 10, y: detailViewAboutSectionLabel.frame.maxY + 5)
        
        aboutSectionButtonImage.frame.origin = CGPoint(x: (detailViewAboutSectionBackgroundView.frame.width - (aboutSectionLabelButton.frame.width + aboutSectionButtonImage.frame.width)) / 2, y: aboutSectionData.frame.maxY + 10)
        aboutSectionLabelButton.frame.origin = CGPoint(x: aboutSectionButtonImage.frame.maxX, y: aboutSectionData.frame.maxY + 10)
        
        var padding: CGFloat = 10
        if(aboutSectionLabelButton.frame.height == CGFloat(0)) {
            padding = 0
        }
        detailViewAboutSectionBackgroundView.frame = CGRect(x: 10, y: headerPhotoImageView.frame.maxY, width: scrollView.bounds.width - 20, height: aboutSectionLabelButton.frame.maxY + padding)
        
        detailViewStatisticsSectionBackgroundView.frame = CGRect(x: 10, y: detailViewAboutSectionBackgroundView.frame.maxY + 10, width: scrollView.bounds.width - 20, height: 300)
        
        detailViewStatisticsSectionLabel.frame = CGRect(x: 10, y: 5, width: detailViewStatisticsSectionBackgroundView.bounds.width - 20, height: detailViewStatisticsSectionLabel.frame.height)
        
        ownerLabel.frame.origin = CGPoint(x: 10, y: detailViewStatisticsSectionLabel.frame.maxY + 5)
        ownerLabelData.frame.origin = CGPoint(x: ownerLabel.frame.maxX, y: detailViewStatisticsSectionLabel.frame.maxY + 5)
        
        operatorLabel.frame.origin = CGPoint(x: 10, y: ownerLabel.frame.maxY + 5)
        operatorLabelData.frame.origin = CGPoint(x: operatorLabel.frame.maxX, y: ownerLabel.frame.maxY + 5)
        
        vesselTypeLabel.frame.origin = CGPoint(x: 10, y: operatorLabel.frame.maxY + 5)
        vesselTypeLabelData.frame = CGRect(x: vesselTypeLabel.frame.maxX, y: operatorLabel.frame.maxY + 5, width: detailViewStatisticsSectionBackgroundView.frame.width - vesselTypeLabel.frame.width - 20, height: vesselTypeLabel.frame.height)
        
        yearsInFleetLabel.frame.origin = CGPoint(x: 10, y: vesselTypeLabel.frame.maxY + 5)
        yearsInFleetLabelData.frame.origin = CGPoint(x: yearsInFleetLabel.frame.maxX, y: vesselTypeLabel.frame.maxY + 5)
        
        previousNamesLabelData.frame.size = updateFrameUsingAdjacentLabel(for: previousNamesLabelData, using: previousNamesLabel, in: detailViewStatisticsSectionBackgroundView)
        previousNamesLabel.frame.origin = CGPoint(x: 10, y: yearsInFleetLabel.frame.maxY + 5)
        previousNamesLabelData.frame.origin = CGPoint(x: previousNamesLabel.frame.maxX, y: yearsInFleetLabel.frame.maxY + 5)
        
        padding = 5
        if(previousNamesLabelData.frame.height == CGFloat(0)) {
            padding = 0
        }
        
        yearBuiltLabel.frame.origin = CGPoint(x: 10, y: previousNamesLabelData.frame.maxY + padding)
        yearBuiltLabelData.frame.origin = CGPoint(x: yearBuiltLabel.frame.maxX, y: previousNamesLabelData.frame.maxY + padding)
        
        imoNumberLabel.frame.origin = CGPoint(x: 10, y: yearBuiltLabel.frame.maxY + 5)
        imoNumberLabelData.frame.origin = CGPoint(x: imoNumberLabel.frame.maxX, y: yearBuiltLabel.frame.maxY + 5)
        
        homePortLabel.frame.origin = CGPoint(x: 10, y: imoNumberLabel.frame.maxY + 5)
        homePortLabelData.frame.origin = CGPoint(x: homePortLabel.frame.maxX, y: imoNumberLabel.frame.maxY + 5)
        
        hullLengthLabel.frame.origin = CGPoint(x: 10, y: homePortLabel.frame.maxY + 5)
        hullLengthLabelData.frame.origin = CGPoint(x: hullLengthLabel.frame.maxX, y: homePortLabel.frame.maxY + 5)
        
        hullWidthLabel.frame.origin = CGPoint(x: 10, y: hullLengthLabel.frame.maxY + 5)
        hullWidthLabelData.frame.origin = CGPoint(x: hullWidthLabel.frame.maxX, y: hullLengthLabel.frame.maxY + 5)
        
        marineFleetLabel.frame.origin = CGPoint(x: 10, y: hullWidthLabel.frame.maxY + 5)
        marineFleetLabelData.frame.origin = CGPoint(x: marineFleetLabel.frame.maxX, y: hullWidthLabel.frame.maxY + 5)
        
        detailViewStatisticsSectionBackgroundView.frame = CGRect(x: 10, y: detailViewAboutSectionBackgroundView.frame.maxY + 10, width: scrollView.bounds.width - 20, height: marineFleetLabel.frame.maxY + 10)
        
        detailViewMilestonesSectionBackgroundView.frame = CGRect(x: 10, y: detailViewStatisticsSectionBackgroundView.frame.maxY + 10, width: scrollView.bounds.width - 20, height: 300)

        detailViewMilestonesSectionLabel.frame = CGRect(x: 10, y: 5, width: detailViewMilestonesSectionBackgroundView.bounds.width - 20, height: detailViewMilestonesSectionLabel.frame.height)
        
        missionsDeployedLabel.frame.size = updateFrameUsingBackgroundView(for: missionsDeployedLabel, using: detailViewMilestonesSectionBackgroundView)
        missionsDeployedLabel.frame.origin = CGPoint(x: 10, y: detailViewMilestonesSectionLabel.frame.maxY + 5)
        
        missionRoleLabel.frame.size = updateFrameUsingBackgroundView(for: missionRoleLabel, using: detailViewMilestonesSectionBackgroundView)
        missionRoleLabel.frame.origin = CGPoint(x: 10, y: missionsDeployedLabel.frame.maxY + 5)
        
        missionInvolementTimelineLabel.frame.size = updateFrameUsingBackgroundView(for: missionInvolementTimelineLabel, using: detailViewMilestonesSectionBackgroundView)
        missionInvolementTimelineLabel.frame.origin = CGPoint(x: 10, y: missionRoleLabel.frame.maxY + 5)

        detailViewMilestonesSectionBackgroundView.frame = CGRect(x: 10, y: detailViewStatisticsSectionBackgroundView.frame.maxY + 10, width: scrollView.bounds.width - 20, height: missionInvolementTimelineLabel.frame.maxY + 10)
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: detailViewMilestonesSectionBackgroundView.frame.maxY + 10)
    }
    
    func updateFrameUsingBackgroundView(for label: UILabel, using view: UIView) -> CGSize {
        let maxSize = CGSize(width: view.bounds.width - 20, height: 1000)
        return label.sizeThatFits(maxSize)
    }
    
    func updateFrameUsingAdjacentLabel(for label: UILabel, using titleLabel: UILabel, in background: UIView) -> CGSize {
        let maxSize = CGSize(width: background.bounds.width - titleLabel.frame.width - 20, height: 1000)
        return label.sizeThatFits(maxSize)
    }
    
    func getProperWording(for number: Int) -> String {
        if(number == 1) {
            return "once"
        } else if(number == 2) {
            return "twice"
        } else {
            return "\(number) times"
        }
    }
    
    @objc func pushDetailViewAboutViewController() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: SupportVesselDetailViewAboutViewController.identifier) as? SupportVesselDetailViewAboutViewController
        viewController?.stringArray = currentVessel.supportVesselDescription
        viewController?.vesselName = currentVessel.supportVesselName
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @objc func pushHomePortViewController() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: SupportVesselHomePortViewController.identifier) as? SupportVesselHomePortViewController
        viewController?.homeport = currentVessel.portOfCalling
        viewController?.latitude = currentVessel.portOfCallingLatitude
        viewController?.longitude = currentVessel.portOfCallingLongitude
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @objc func linkTap(sender: CustomTapGestureRecognizer) {
        if let url = URL(string: sender.customURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
