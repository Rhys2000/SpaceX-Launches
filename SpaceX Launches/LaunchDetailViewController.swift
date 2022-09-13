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
    var heightPadding: CGFloat = 5
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    var countdownTimer = Timer()
    
    var currentLaunch = Launch(launchID: 1, launchName: "", alternativeLaunchName: "", abbreviatedLaunchName: "", alternativeAbbreviatedLaunchName: "", liftOffTime: "", launchLocation: .capeCanaveralSpaceForceStation, launchVehicle: .falcon1, orbitalDestination: .leo, launchProvider: "", launchProviderLink: "", customerArray: [""], staticFirePerformed: true, staticFireToLaunchGap: 2, boosterNumbers: ["2"], boosterVariant: .block1, boosterRecoveryAttempted: true, boosterRecoveryMethod: .aborted, boosterRecoveryDistance: [1], boosterRecoveryLocations: [.droneShip], boosterRecoveryOutcome: [.failure], fairingVersion: 1, fairingFlights: [4], fairingRecoveryAttempted: true, fairingPlannedRecoveryMethod: [.aborted], fairingActualRecoveryMethod: [.aborted], fairingRecoveryDistance: 1, fairingRecoveryLocations: [.droneShip], fairingRecoveryOutcome: [.failure], missionSupportShips: [""], missionSupportShipRoles: [""], missionOutcome: .failure)
    
    private let scrollView = UIScrollView()
    private let headerPhotoImageView = UIImageView()
    private let countdownLabel = UILabel()
    private let detailViewMissionStatisticsBackgroundView = UIView()
    private let detailViewMissionStatisticsLabel = UILabel()
    private let liftOffTimeLabel = UILabel()
    private let liftOffTimeLabelDataUserTimezone = UILabel()
    private let liftOffTimeLabelUTC = UILabel()
    private let missionNameLabel = UILabel()
    private let missionNameLabelData = UILabel()
    private let alternativeMissionNameLabel = UILabel()
    private let alternativeMissionNameLabelData = UILabel()
    private let launchProviderLabel = UILabel()
    private let launchProviderLabelData = UILabel()
    private let launchCustomersLabel = UILabel()
    private let launchCustomerLabelData = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = (currentLaunch.launchName == "Starlink" ? currentLaunch.alternativeLaunchName : currentLaunch.launchName)
        
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
        
        detailViewMissionStatisticsLabel.text = "\(currentLaunch.launchName) Mission"
        detailViewMissionStatisticsLabel.font = .boldSystemFont(ofSize: 24)
        detailViewMissionStatisticsLabel.textAlignment = .center
        detailViewMissionStatisticsLabel.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(detailViewMissionStatisticsLabel)
        
        liftOffTimeLabel.text = "Lift Off Time: "
        liftOffTimeLabel.font = .boldSystemFont(ofSize: 15)
        liftOffTimeLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabel)
        
        let localComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: dateFormatter.date(from: currentLaunch.liftOffTime)!)
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm:ss a (zzz)"
        liftOffTimeLabelDataUserTimezone.text = dateFormatter.string(from: calendar.date(from: localComponents)!)
        liftOffTimeLabelDataUserTimezone.font = .systemFont(ofSize: 15)
        liftOffTimeLabelDataUserTimezone.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabelDataUserTimezone)
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let universalComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateFormatter.date(from: currentLaunch.liftOffTime)!)
        dateFormatter.dateFormat = "MMMM d, yyyy h:mm:ss a"
        liftOffTimeLabelUTC.text = dateFormatter.string(from: calendar.date(from: universalComponents)!) + " (UTC)"
        liftOffTimeLabelUTC.font = .systemFont(ofSize: 15)
        liftOffTimeLabelUTC.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(liftOffTimeLabelUTC)
        
        missionNameLabel.text = "Mission Name:"
        missionNameLabel.font = .boldSystemFont(ofSize: 15)
        missionNameLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(missionNameLabel)
        
        missionNameLabelData.text = " \(currentLaunch.launchName) (\(currentLaunch.abbreviatedLaunchName))"
        missionNameLabelData.font = .systemFont(ofSize: 15)
        missionNameLabelData.adjustsFontSizeToFitWidth = true
        detailViewMissionStatisticsBackgroundView.addSubview(missionNameLabelData)
        
        if(currentLaunch.alternativeLaunchName != "") {
            alternativeMissionNameLabel.text = "Alternative Name:"
            alternativeMissionNameLabel.font = .boldSystemFont(ofSize: 15)
            alternativeMissionNameLabel.sizeToFit()
            detailViewMissionStatisticsBackgroundView.addSubview(alternativeMissionNameLabel)
            
            alternativeMissionNameLabelData.text = " \(currentLaunch.alternativeLaunchName)"
            if(currentLaunch.alternativeAbbreviatedLaunchName != "") {
                alternativeMissionNameLabelData.text! += " (\(currentLaunch.alternativeAbbreviatedLaunchName))"
            }
            alternativeMissionNameLabelData.font = .systemFont(ofSize: 15)
            alternativeMissionNameLabelData.adjustsFontSizeToFitWidth = true
            detailViewMissionStatisticsBackgroundView.addSubview(alternativeMissionNameLabelData)
        }
        
        launchProviderLabel.text = "Launch Provider: "
        launchProviderLabel.font = .boldSystemFont(ofSize: 15)
        launchProviderLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(launchProviderLabel)
        
        launchProviderLabelData.text = " SpaceX "
        launchProviderLabelData.font = .systemFont(ofSize: 15)
        launchProviderLabelData.isUserInteractionEnabled = true
        let launchProviderLink = CustomTapGestureRecognizer(target: self, action: #selector(linkTap(sender:)))
        launchProviderLink.customURL = currentLaunch.launchProviderLink
        launchProviderLabelData.addGestureRecognizer(launchProviderLink)
        launchProviderLabelData.sizeToFit()
        launchProviderLabelData.layer.cornerRadius = 7.5
        launchProviderLabelData.layer.borderWidth = 1.0
        launchProviderLabelData.layer.borderColor = UIColor.white.cgColor
        detailViewMissionStatisticsBackgroundView.addSubview(launchProviderLabelData)
        
        launchCustomersLabel.text = "Launch Customers: "
        launchCustomersLabel.font = .boldSystemFont(ofSize: 15)
        launchCustomersLabel.sizeToFit()
        detailViewMissionStatisticsBackgroundView.addSubview(launchCustomersLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        headerPhotoImageView.frame = CGRect(x: sidePadding, y: heightPadding, width: scrollView.bounds.width - (sidePadding * 2), height: 225)
        
        countdownLabel.frame.origin = CGPoint(x: headerPhotoImageView.frame.width - countdownLabel.frame.width, y: headerPhotoImageView.frame.minY + heightPadding)
        
        detailViewMissionStatisticsBackgroundView.frame = CGRect(x: sidePadding, y: headerPhotoImageView.frame.maxY, width: scrollView.bounds.width - (sidePadding * 2), height: 300)
        
        detailViewMissionStatisticsLabel.frame = CGRect(x: sidePadding, y: heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - (sidePadding * 2), height: 25)
        
        liftOffTimeLabel.frame.origin = CGPoint(x: sidePadding, y: detailViewMissionStatisticsLabel.frame.maxY + heightPadding)
        
        liftOffTimeLabelDataUserTimezone.frame = CGRect(x: liftOffTimeLabel.frame.maxX, y: detailViewMissionStatisticsLabel.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - liftOffTimeLabel.frame.width - (2 * sidePadding), height: liftOffTimeLabel.frame.height)
        
        liftOffTimeLabelUTC.frame = CGRect(x: liftOffTimeLabel.frame.maxX, y: liftOffTimeLabelDataUserTimezone.frame.maxY + heightPadding, width: liftOffTimeLabelDataUserTimezone.frame.width, height: liftOffTimeLabel.frame.height)
        
        missionNameLabel.frame.origin = CGPoint(x: sidePadding, y: liftOffTimeLabelUTC.frame.maxY + heightPadding)
        
        missionNameLabelData.frame = CGRect(x: missionNameLabel.frame.maxX, y: liftOffTimeLabelUTC.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - missionNameLabel.frame.width - (2 * sidePadding), height: missionNameLabel.frame.height)
        
        if(alternativeMissionNameLabel.frame.height == CGFloat(0)) {
            heightPadding = 0
        }
        alternativeMissionNameLabel.frame.origin = CGPoint(x: sidePadding, y: missionNameLabel.frame.maxY + heightPadding)
        
        alternativeMissionNameLabelData.frame = CGRect(x: alternativeMissionNameLabel.frame.maxX, y: missionNameLabel.frame.maxY + heightPadding, width: detailViewMissionStatisticsBackgroundView.frame.width - alternativeMissionNameLabel.frame.width - (2 * sidePadding), height: alternativeMissionNameLabel.frame.height)
        heightPadding = 5
        
        launchProviderLabel.frame.origin = CGPoint(x: sidePadding, y: alternativeMissionNameLabel.frame.maxY + heightPadding)
        
        launchProviderLabelData.frame.origin = CGPoint(x: launchProviderLabel.frame.maxX, y: alternativeMissionNameLabel.frame.maxY + heightPadding)
        
        launchCustomersLabel.frame.origin = CGPoint(x: sidePadding, y: launchProviderLabel.frame.maxY + heightPadding)
        
        var x: CGFloat = launchCustomersLabel.frame.maxX
        var y: CGFloat = launchCustomersLabel.frame.origin.y
        for customer in currentLaunch.customerArray {
            let tempLabel = UILabel(frame: CGRect(x: x, y: y, width: 0, height: 0))
            tempLabel.text = " \(customer) "
            tempLabel.font = .systemFont(ofSize: 15)
            tempLabel.isUserInteractionEnabled = true
            let temp = CustomerTapGestureRecognizer(target: self, action: #selector(pushCustomerDetailViewController(sender:)))
            temp.customer?.customerName = customer
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
        }
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
        print("Tapped")
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
