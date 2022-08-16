//
//  LaunchCollectionViewCell.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var launchPreviewImage: UIImageView!
    @IBOutlet weak var missionName: UILabel!
    @IBOutlet weak var launchCountdown: UILabel!
    
    var countdownTimer = Timer()
    let dateFormatter = DateFormatter()
    let numberOfSecondsInADay = 86400
    let numberOfSecondsInAnHour = 3600
    let numberOfSecondsInAMinute = 60
    
    func createLaunchPreview(with currentLaunch: Launch) {
        //launchPreviewImage
        launchPreviewImage.image = UIImage(named: "SpaceXLaunch\(currentLaunch.launchID)")
        launchPreviewImage.layer.cornerRadius = 10.0
        launchPreviewImage.contentMode = UIView.ContentMode.scaleAspectFill
        launchPreviewImage.layer.borderColor = getLaunchPreviewImageBorderColor(using: currentLaunch.missionOutcome)
        launchPreviewImage.layer.borderWidth = 3.0
        
        func getLaunchPreviewImageBorderColor(using outcome: Outcome) -> CGColor {
            switch outcome {
            case .success:
                return UIColor.green.cgColor
            case .failure:
                return UIColor.red.cgColor
            case .upcoming:
                return UIColor.yellow.cgColor
            case .unknown:
                return UIColor.orange.cgColor
            }
        }
        
        //missionName
        missionName.text = currentLaunch.launchName + " "
        missionName.textColor = .darkText
        missionName.font = UIFont.boldSystemFont(ofSize: 22)
        missionName.adjustsFontSizeToFitWidth = true
        missionName.backgroundColor = .white
        missionName.layer.cornerRadius = 5
        missionName.layer.masksToBounds = true
        missionName.textAlignment = .center
        missionName.layer.opacity = 0.6
        
        //launchCountdown
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en-US")
        print(currentLaunch.liftOffTime)
        let userTimezoneLaunchTime = dateFormatter.date(from: currentLaunch.liftOffTime)!
        refreshCountdownClock()
        self.countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in refreshCountdownClock() })

        func refreshCountdownClock() {
            let userTimezoneCurrentTime = Date()
            var totalSecondsUntilLaunch = Int(userTimezoneLaunchTime - userTimezoneCurrentTime)
            if(totalSecondsUntilLaunch < 0) {
                dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss a "
                launchCountdown.text = dateFormatter.string(from: userTimezoneLaunchTime)
            } else {
                let daysUntilLaunch = totalSecondsUntilLaunch / numberOfSecondsInADay
                totalSecondsUntilLaunch = Int(totalSecondsUntilLaunch % numberOfSecondsInADay)
                let hoursUntilLaunch = totalSecondsUntilLaunch / numberOfSecondsInAnHour
                totalSecondsUntilLaunch = Int(totalSecondsUntilLaunch % numberOfSecondsInAnHour)
                let minutesUntilLaunch = totalSecondsUntilLaunch / numberOfSecondsInAMinute
                totalSecondsUntilLaunch = Int(totalSecondsUntilLaunch % numberOfSecondsInAMinute)
                let secondsUntilLaunch = totalSecondsUntilLaunch
                if(daysUntilLaunch > 0) {
                    var dayFormat = ""
                    if(daysUntilLaunch == 1) {
                        dayFormat = "day"
                    } else {
                        dayFormat = "days"
                    }
                    launchCountdown.text = "T - \(daysUntilLaunch) \(dayFormat) " + String(format: "%02d:%02d:%02d", hoursUntilLaunch, minutesUntilLaunch, secondsUntilLaunch) + " "
                } else {
                    launchCountdown.text = "T - " + String(format: "%02d:%02d:%02d", hoursUntilLaunch, minutesUntilLaunch, secondsUntilLaunch) + " "
                }
            }
        }
        launchCountdown.backgroundColor = .white
        launchCountdown.layer.cornerRadius = 5
        launchCountdown.layer.masksToBounds = true
        launchCountdown.textColor = .darkText
        launchCountdown.adjustsFontSizeToFitWidth = true
        launchCountdown.textAlignment = .center
        launchCountdown.layer.opacity = 0.6
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
