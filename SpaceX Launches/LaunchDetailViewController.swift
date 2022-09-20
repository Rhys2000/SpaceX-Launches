//
//  LaunchDetailViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/10/22.
//

import UIKit

class CustomerTapGestureRecognizer: UITapGestureRecognizer {
    var customer: Customer?
}

class LaunchDetailViewController: UIViewController {
    
    static let identifier = "LaunchDetailViewController"
    
    let sidePadding: CGFloat = 10
    var heightPadding: CGFloat = 8
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    var countdownTimer = Timer()
    
    var customerAssociatedWithLaunch = [Customer]()
    
    var currentLaunch = Launch(launchID: 1, launchName: "", abbreviatedLaunchName: "", alternativeLaunchName: "", liftOffTime: "", launchLocation: .capeCanaveralSpaceForceStation, launchVehicle: .falcon1, orbitalDestination: .leo, launchProvider: "", launchProviderLink: "", customerArray: [""], staticFirePerformed: true, staticFireToLaunchGap: 2, boosterNumbers: ["2"], boosterVariant: .block1, boosterRecoveryAttempted: true, boosterRecoveryMethod: .aborted, boosterRecoveryDistance: [1], boosterRecoveryLocations: [.droneShip], boosterRecoveryOutcome: [.failure], fairingVersion: 1, fairingFlights: [4], fairingRecoveryAttempted: true, fairingPlannedRecoveryMethod: [.aborted], fairingActualRecoveryMethod: [.aborted], fairingRecoveryDistance: 1, fairingRecoveryLocations: [.droneShip], fairingRecoveryOutcome: [.failure], missionSupportShips: [""], missionSupportShipRoles: [""], missionOutcome: .failure)
    
    private let scrollView = UIScrollView()
    private let headerPhotoImageView = UIImageView()
    private let countdownLabel = UILabel()
    private let detailViewMissionStatisticsBackgroundView = UIView()
    private let detailViewMissionStatisticsLabel = UILabel()
    private let sectionTitleSeparator = UIView()
    private let liftOffTimeLabel = UILabel()
    private let liftOffTimeLabelDataUserTimezone = UILabel()
    private let liftOffTimeLabelUTC = UILabel()
    private let liftOffTimeSeparator = UIView()
    private let missionNameLabel = UILabel()
    private let missionNameLabelData = UILabel()
    private let abbreviatedNameLabel = UILabel()
    private let abbreviatedNameLabelData = UILabel()
    private let alternativeMissionNameLabel = UILabel()
    private let alternativeMissionNameLabelData = UILabel()
    private let missionNameSeparator = UIView()
    private let launchProviderLabel = UILabel()
    private let launchProviderLabelData = UILabel()
    private let launchProviderSeparator = UIView()
    private let launchCustomersLabel = UILabel()
    private let launchCustomerLabelData = UILabel()
    private let launchVehicleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentLaunch.launchName
        
        for customer in currentLaunch.customerArray {
            for element in CustomerLoader().allCutomers {
                if(customer == element.abbreviatedCustomerName) {
                    customerAssociatedWithLaunch.append(element)
                }
            }
        }
        //print(customerAssociatedWithLaunch)
        
        view.addSubview(scrollView)
        
        headerPhotoImageView.image = UIImage(named: "SpaceXHeaderPhoto\(Int.random(in: 1...10))")
        headerPhotoImageView.contentMode = .scaleAspectFill
        headerPhotoImageView.clipsToBounds = true
        headerPhotoImageView.layer.cornerRadius = 10.0
        headerPhotoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        scrollView.addSubview(headerPhotoImageView)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en-US")
        let userTimezoneLaunchTime = dateFormatter.date(from: currentLaunch.liftOffTime)!
        let userTimezoneCurrentTime = Date()
        refreshCountdownClock(using: userTimezoneLaunchTime)
        countdownLabel.font = .boldSystemFont(ofSize: 24)
        countdownLabel.layer.cornerRadius = 10.0
        countdownLabel.layer.borderWidth = 1
        countdownLabel.layer.borderColor = UIColor.white.cgColor
        countdownLabel.layer.opacity = 0.7
        countdownLabel.sizeToFit()
        if(userTimezoneCurrentTime < userTimezoneLaunchTime) {
            self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in refreshCountdownClock(using: userTimezoneLaunchTime) })
            scrollView.addSubview(countdownLabel)
        }
        
        detailViewMissionStatisticsBackgroundView.backgroundColor = .gray
        detailViewMissionStatisticsBackgroundView.layer.cornerRadius = 10.0
        detailViewMissionStatisticsBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        scrollView.addSubview(detailViewMissionStatisticsBackgroundView)
        
        detailViewMissionStatisticsLabel.text = "Mission Details"
        detailViewMissionStatisticsLabel.font = .boldSystemFont(ofSize: 28)
        detailViewMissionStatisticsLabel.textAlignment = .center
        detailViewMissionStatisticsLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(detailViewMissionStatisticsLabel)
        
        sectionTitleSeparator.backgroundColor = .white
        sectionTitleSeparator.layer.opacity = 0.75
        sectionTitleSeparator.layer.cornerRadius = 2.0
        detailViewMissionStatisticsBackgroundView.addSubview(sectionTitleSeparator)
        
        liftOffTimeLabel.text = "LiftOff: "
        liftOffTimeLabel.font = .boldSystemFont(ofSize: liftOffTimeLabel.font.pointSize)
        liftOffTimeLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabel)
        
        let localComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: dateFormatter.date(from: currentLaunch.liftOffTime)!)
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm:ss a (zzz)"
        liftOffTimeLabelDataUserTimezone.text = dateFormatter.string(from: calendar.date(from: localComponents)!)
        liftOffTimeLabelDataUserTimezone.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabelDataUserTimezone)
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let universalComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateFormatter.date(from: currentLaunch.liftOffTime)!)
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm:ss a"
        liftOffTimeLabelUTC.text = dateFormatter.string(from: calendar.date(from: universalComponents)!) + " (UTC)"
        liftOffTimeLabelUTC.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabelUTC)
        
        liftOffTimeSeparator.backgroundColor = .white
        liftOffTimeSeparator.layer.opacity = 0.5
        liftOffTimeSeparator.layer.cornerRadius = 1.0
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeSeparator)
        
        missionNameLabel.text = "Name: "
        missionNameLabel.font = .boldSystemFont(ofSize: missionNameLabel.font.pointSize)
        missionNameLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(missionNameLabel)
        
        if(currentLaunch.launchName == currentLaunch.abbreviatedLaunchName) {
            missionNameLabelData.text = currentLaunch.launchName
        } else {
            missionNameLabelData.text = "\(currentLaunch.launchName) (\(currentLaunch.abbreviatedLaunchName))"
        }
        missionNameLabelData.sizeToFit()
        
        if(missionNameLabelData.frame.width + missionNameLabel.frame.width > view.bounds.width - (4 * sidePadding)) {
            abbreviatedNameLabel.text = "Abbr. Name: "
            abbreviatedNameLabel.font = .boldSystemFont(ofSize: abbreviatedNameLabel.font.pointSize)
            abbreviatedNameLabel.sizeToFit()
            detailViewMissionStatisticsBackgroundView.addSubview(abbreviatedNameLabel)

            abbreviatedNameLabelData.text = currentLaunch.abbreviatedLaunchName
            abbreviatedNameLabelData.sizeToFit()
            detailViewMissionStatisticsBackgroundView.addSubview(abbreviatedNameLabelData)

            missionNameLabelData.text = "\(currentLaunch.launchName)"
        }
        missionNameLabelData.numberOfLines = 0
        missionNameLabelData.lineBreakMode = .byWordWrapping
        detailViewMissionStatisticsBackgroundView.addSubview(missionNameLabelData)
        
        if(currentLaunch.alternativeLaunchName != "") {
            alternativeMissionNameLabel.text = "Alt. Name:"
            alternativeMissionNameLabel.font = .boldSystemFont(ofSize: alternativeMissionNameLabel.font.pointSize)
            alternativeMissionNameLabel.sizeToFit()
            detailViewMissionStatisticsBackgroundView.addSubview(alternativeMissionNameLabel)
            
            alternativeMissionNameLabelData.text = " \(currentLaunch.alternativeLaunchName)"
            alternativeMissionNameLabelData.adjustsFontSizeToFitWidth = true
            alternativeMissionNameLabelData.sizeToFit()
            detailViewMissionStatisticsBackgroundView.addSubview(alternativeMissionNameLabelData)
        }
        
        missionNameSeparator.backgroundColor = .white
        missionNameSeparator.layer.opacity = 0.5
        missionNameSeparator.layer.cornerRadius = 1.0
        detailViewMissionStatisticsBackgroundView.addSubview(missionNameSeparator)
        
        launchProviderLabel.text = "Launch Provider: "
        launchProviderLabel.font = .boldSystemFont(ofSize: launchProviderLabel.font.pointSize)
        launchProviderLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(launchProviderLabel)

        launchProviderLabelData.text = " SpaceX "
        launchProviderLabelData.isUserInteractionEnabled = true
        let launchProviderLink = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        launchProviderLink.customURL = currentLaunch.launchProviderLink
        launchProviderLabelData.addGestureRecognizer(launchProviderLink)
        launchProviderLabelData.sizeToFit()
        launchProviderLabelData.layer.cornerRadius = 7.5
        launchProviderLabelData.layer.borderWidth = 1.0
        launchProviderLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewMissionStatisticsBackgroundView.addSubview(launchProviderLabelData)
        
        launchProviderSeparator.backgroundColor = .white
        launchProviderSeparator.layer.opacity = 0.5
        launchProviderSeparator.layer.cornerRadius = 1.0
        detailViewMissionStatisticsBackgroundView.addSubview(launchProviderSeparator)

        launchCustomersLabel.text = "Customers: "
        launchCustomersLabel.font = .boldSystemFont(ofSize: launchCustomersLabel.font.pointSize)
        launchCustomersLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(launchCustomersLabel)

        launchVehicleLabel.text = "Vehicle: "
        launchVehicleLabel.font = .boldSystemFont(ofSize: launchVehicleLabel.font.pointSize)
        launchVehicleLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(launchVehicleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        headerPhotoImageView.frame = CGRect(x: sidePadding, y: heightPadding, width: scrollView.bounds.width - (sidePadding * 2), height: 225)
        
        countdownLabel.frame.origin = CGPoint(x: headerPhotoImageView.frame.width - countdownLabel.frame.width, y: headerPhotoImageView.frame.minY + heightPadding)
        
        detailViewMissionStatisticsBackgroundView.frame = CGRect(x: sidePadding, y: headerPhotoImageView.frame.maxY, width: scrollView.bounds.width - (sidePadding * 2), height: 300)
        
        detailViewMissionStatisticsLabel.frame = CGRect(x: sidePadding, y: 5, width: detailViewMissionStatisticsBackgroundView.frame.width - (sidePadding * 2), height: detailViewMissionStatisticsLabel.frame.height)
        
        sectionTitleSeparator.frame = CGRect(x: sidePadding, y: detailViewMissionStatisticsLabel.frame.maxY + 2, width: detailViewMissionStatisticsBackgroundView.frame.width - (sidePadding * 2), height: 4)
        
        liftOffTimeLabel.frame.origin = CGPoint(x: sidePadding, y: sectionTitleSeparator.frame.maxY + heightPadding)
        
        liftOffTimeLabelDataUserTimezone.frame = CGRect(x: liftOffTimeLabel.frame.maxX, y: sectionTitleSeparator.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - liftOffTimeLabel.frame.width - (2 * sidePadding), height: liftOffTimeLabel.frame.height)
        
        liftOffTimeLabelUTC.frame = CGRect(x: liftOffTimeLabel.frame.maxX, y: liftOffTimeLabelDataUserTimezone.frame.maxY + 5, width: liftOffTimeLabelDataUserTimezone.frame.width, height: liftOffTimeLabel.frame.height)
        
        liftOffTimeSeparator.frame = CGRect(x: sidePadding, y: liftOffTimeLabelUTC.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - (2 * sidePadding), height: 2)
        
        missionNameLabelData.frame.size = updateFrameUsingAdjacentLabel(for: missionNameLabelData, using: missionNameLabel, in: detailViewMissionStatisticsBackgroundView)
        missionNameLabel.frame.origin = CGPoint(x: sidePadding, y: liftOffTimeSeparator.frame.maxY + heightPadding)
        missionNameLabelData.frame.origin = CGPoint(x: missionNameLabel.frame.maxX, y: liftOffTimeSeparator.frame.maxY + heightPadding)
        
        heightPadding = 5
        if(abbreviatedNameLabel.frame.height == CGFloat(0)) {
            heightPadding = 0
        }
        abbreviatedNameLabel.frame.origin = CGPoint(x: sidePadding, y: missionNameLabelData.frame.maxY + heightPadding)
        abbreviatedNameLabelData.frame.origin = CGPoint(x: abbreviatedNameLabel.frame.maxX, y: missionNameLabelData.frame.maxY + heightPadding)
        heightPadding = 5
        
        if(alternativeMissionNameLabel.frame.height == CGFloat(0)) {
            heightPadding = 0
        }
        alternativeMissionNameLabel.frame.origin = CGPoint(x: sidePadding, y: abbreviatedNameLabel.frame.maxY + heightPadding)
        alternativeMissionNameLabelData.frame  = CGRect(x: alternativeMissionNameLabel.frame.maxX, y: abbreviatedNameLabel.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - alternativeMissionNameLabel.frame.width - (2 * sidePadding), height: alternativeMissionNameLabel.frame.height)
        heightPadding = 8
        
        missionNameSeparator.frame = CGRect(x: sidePadding, y: alternativeMissionNameLabel.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - (2 * sidePadding), height: 2)
        
        launchProviderLabel.frame.origin = CGPoint(x: sidePadding, y: missionNameSeparator.frame.maxY + heightPadding)
        launchProviderLabelData.frame.origin = CGPoint(x: launchProviderLabel.frame.maxX, y: missionNameSeparator.frame.maxY + heightPadding)
        
        launchProviderSeparator.frame = CGRect(x: sidePadding, y: launchProviderLabel.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - (2 * sidePadding), height: 2)
        
        launchCustomersLabel.frame.origin = CGPoint(x: sidePadding, y: launchProviderSeparator.frame.maxY + heightPadding)
        
        var x: CGFloat = launchCustomersLabel.frame.maxX
        var y: CGFloat = launchCustomersLabel.frame.origin.y
        var finalLabelHeight: CGFloat = 0
        for customer in customerAssociatedWithLaunch {
            let tempLabel = GradientLabel(frame: CGRect(x: x, y: y, width: 0, height: 0))
            tempLabel.text = " \(customer.abbreviatedCustomerName) "
            tempLabel.isUserInteractionEnabled = true
            let temp = CustomerTapGestureRecognizer(target: self, action: #selector(pushCustomerDetailViewController(sender:)))
            temp.customer = customer
            tempLabel.gradientColors = [UIColor.blue.cgColor, UIColor.red.cgColor, UIColor.white.cgColor]
            tempLabel.addGestureRecognizer(temp)
            tempLabel.sizeToFit()
            tempLabel.layer.cornerRadius = 7.5
            tempLabel.layer.borderWidth = 1
            tempLabel.layer.borderColor = UIColor.white.cgColor
            if(tempLabel.frame.maxX > detailViewMissionStatisticsBackgroundView.frame.width - (2 * sidePadding)) {
                x = 10
                y = tempLabel.frame.maxY + heightPadding
                tempLabel.frame.origin = CGPoint(x: x, y: y)
            }
            x = tempLabel.frame.maxX + 5
            detailViewMissionStatisticsBackgroundView.addSubview(tempLabel)
            finalLabelHeight = y + tempLabel.frame.height
        }
        
        launchVehicleLabel.frame.origin = CGPoint(x: sidePadding, y: finalLabelHeight + heightPadding)
        
        detailViewMissionStatisticsBackgroundView.frame.size.height = CGFloat(launchVehicleLabel.frame.maxY + 10)
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: detailViewMissionStatisticsBackgroundView.frame.maxY + 10)
    }
    
    func updateFrameUsingAdjacentLabel(for label: UILabel, using titleLabel: UILabel, in background: UIView) -> CGSize {
        let maxSize = CGSize(width: background.bounds.width - titleLabel.frame.width - 20, height: 1000)
        return label.sizeThatFits(maxSize)
    }
    
    func refreshCountdownClock(using liftOffTime: Date) {
        let currentTime = Date()
        var totalSecondsUntilLaunch = Int(liftOffTime - currentTime)
        let daysToLaunch = totalSecondsUntilLaunch / 86400
        totalSecondsUntilLaunch = totalSecondsUntilLaunch % 86400
        let hoursToLaunch = totalSecondsUntilLaunch / 3600
        totalSecondsUntilLaunch = totalSecondsUntilLaunch % 3600
        let minutesToLaunch = totalSecondsUntilLaunch / 60
        totalSecondsUntilLaunch = totalSecondsUntilLaunch % 60
        if(daysToLaunch > 0) {
            let dayFormat = (daysToLaunch == 1 ? "day" : "days")
            countdownLabel.text = " T - \(daysToLaunch) \(dayFormat) " + String(format: "%02d:%02d:%02d", hoursToLaunch, minutesToLaunch, totalSecondsUntilLaunch) + " "
        } else {
            countdownLabel.text = " T - " + String(format: "%02d:%02d:%02d", hoursToLaunch, minutesToLaunch, totalSecondsUntilLaunch) + " "
        }
        countdownLabel.sizeToFit()
        countdownLabel.frame.origin = CGPoint(x: headerPhotoImageView.frame.width - countdownLabel.frame.width, y: headerPhotoImageView.frame.minY + heightPadding)
    }
    
    @objc func linkTap(sender: CustomTapGestureRecognizer) {
        if let url = URL(string: sender.customURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func pushCustomerDetailViewController(sender: CustomerTapGestureRecognizer) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: CustomerDetailViewController.identifier) as? CustomerDetailViewController
        viewController?.customer = sender.customer!
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
        
//    func getSuffixForNumber(currentValue: Int) -> String {
//        if(currentValue == 11 || currentValue == 12 || currentValue == 13) {
//            return "th"
//        } else {
//            switch(currentValue % 10) {
//            case 1:
//                return "st"
//            case 2:
//                return "nd"
//            case 3:
//                return "rd"
//            default:
//                return "th"
//            }
//        }
//    }
    
}
