//
//  LaunchCollectionViewCell.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LaunchCollectionViewCell"
    
    let dateFormatter = DateFormatter()
    var countdownTimer = Timer()
    
    private let launchPreviewImage = UIImageView()
    private let missionNameLabel = UILabel()
    private let missionDateLabel = UILabel()
    
    func createLaunchPreview(with currentLaunch: Launch) {
        launchPreviewImage.image = UIImage(named: "SpaceXLaunch\(currentLaunch.launchID)")
        if(launchPreviewImage.image == nil) {
            launchPreviewImage.image = UIImage(named: "UpcomingSpaceXLaunch\(Int.random(in: 1...10))")
        }
        launchPreviewImage.contentMode = .scaleToFill
        launchPreviewImage.layer.masksToBounds = true
        launchPreviewImage.layer.cornerRadius = 10.0
        launchPreviewImage.layer.borderWidth = 3.0
        launchPreviewImage.layer.borderColor = (currentLaunch.missionOutcome == .success ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor) //Change to function for all outcomes
        contentView.addSubview(launchPreviewImage)
        
        if(currentLaunch.abbreviatedLaunchName == "Starlink") {
            missionNameLabel.text = " \(currentLaunch.alternativeLaunchName) "
        } else {
            missionNameLabel.text = " " + currentLaunch.abbreviatedLaunchName + " "
        }
        missionNameLabel.backgroundColor = .white
        missionNameLabel.font = .systemFont(ofSize: 22)
        missionNameLabel.textColor = .black
        let tempLabel = UILabel()
        tempLabel.text = " " + currentLaunch.abbreviatedLaunchName + " "
        tempLabel.font = .systemFont(ofSize: 22)
        tempLabel.sizeToFit()
        if(tempLabel.frame.width > contentView.frame.width - 10) {
            missionNameLabel.frame = CGRect(x: contentView.frame.minX + 5, y: contentView.frame.minY + 5, width: contentView.frame.width - 10, height: 25)
            missionNameLabel.adjustsFontSizeToFitWidth = true
        } else {
            missionNameLabel.sizeToFit()
        }
        missionNameLabel.layer.masksToBounds = true
        missionNameLabel.layer.cornerRadius = 10.0
        missionNameLabel.layer.opacity = 0.6
        contentView.addSubview(missionNameLabel)
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en-US")
        let userTimezoneLaunchTime = dateFormatter.date(from: currentLaunch.liftOffTime)!
        let userTimezoneCurrentTime = Date()
        missionDateLabel.text = "Calculating..."
        userTimezoneCurrentTime > userTimezoneLaunchTime ? previousLaunchDate(using: userTimezoneLaunchTime) : upcomingLaunchCountdown(using: userTimezoneLaunchTime)
        missionDateLabel.frame.size = CGSize(width: contentView.frame.width - 10, height: 21)
        missionDateLabel.adjustsFontSizeToFitWidth = true
        missionDateLabel.backgroundColor = .white
        missionDateLabel.textColor = .black
        missionDateLabel.layer.cornerRadius = 10.0
        missionDateLabel.layer.opacity = 0.6
        missionDateLabel.layer.masksToBounds = true
        contentView.addSubview(missionDateLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        launchPreviewImage.image = nil
        missionNameLabel.text = nil
        missionDateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        launchPreviewImage.frame = CGRect(x: 0, y: 0, width: 175, height: 300)
        missionNameLabel.frame.origin = CGPoint(x: (contentView.frame.width - missionNameLabel.frame.width) / 2, y: contentView.frame.minY + 5)
        missionDateLabel.frame.origin = CGPoint(x: contentView.frame.minX + 5, y: contentView.frame.maxY - missionDateLabel.frame.height - 5)
    }
    
    func upcomingLaunchCountdown(using date: Date) {
        missionDateLabel.textAlignment = .center
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in refreshCountdownClock(using: date) })
    }
    
    func previousLaunchDate(using date: Date) {
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a"
        missionDateLabel.text = " \(dateFormatter.string(from: date)) "
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
            missionDateLabel.text = "T - \(daysToLaunch) \(dayFormat) " + String(format: "%02d:%02d:%02d", hoursToLaunch, minutesToLaunch, totalSecondsUntilLaunch) + " "
        } else {
            missionDateLabel.text = "T - " + String(format: "%02d:%02d:%02d", hoursToLaunch, minutesToLaunch, totalSecondsUntilLaunch) + " "
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
