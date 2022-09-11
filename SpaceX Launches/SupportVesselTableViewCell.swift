//
//  SupportVesselTableViewCell.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/3/22.
//

import UIKit

class SupportVesselTableViewCell: UITableViewCell {
    
    static let identifier = "SupportVesselTableViewCell"
    
    private let supportVesselImageView = UIImageView()
    private let supportVesselBackgroundView = UIView()
    private let photographerTagLabel = UILabel()
    private let supportVesselNameLabel = UILabel()
    private let supportVesselServiceLabel = UILabel()
    private let supportVesselYearsOfServiceLabel = UILabel()
    private let supportVesselStatusLabel = UILabel()
    private let supportVesselOperationStatusLabel = UILabel()
    private let vesselFlagLabel = UILabel()
    private let supportVesselCountryOfRegistration = UILabel()
    private let homePortLabel = UILabel()
    private let homePortLabelData = UILabel()
    
    public func createSupportVesselPreview(with currentVessel: SupportVessel) {
        
        //SupportVesselPreview image settings
        supportVesselImageView.image = UIImage(named: currentVessel.supportVesselName.replacingOccurrences(of: " ", with: ""))
        supportVesselImageView.contentMode = .scaleAspectFill
        supportVesselImageView.clipsToBounds = true
        supportVesselImageView.layer.cornerRadius = 10.0
        supportVesselImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //SupportVesselPreview card background settings
        supportVesselBackgroundView.backgroundColor = .gray
        supportVesselBackgroundView.layer.cornerRadius = 10.0
        supportVesselBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        //Photographer Credit settings
        photographerTagLabel.text = " Photo Credit: " + currentVessel.photographerCredit + " "
        photographerTagLabel.font = .systemFont(ofSize: 8)
        photographerTagLabel.sizeToFit()
        photographerTagLabel.layer.opacity = 0.7
        photographerTagLabel.layer.cornerRadius = 3.0
        photographerTagLabel.layer.masksToBounds = true
        
        //SupportVesselName label settings
        supportVesselNameLabel.text = " " + currentVessel.supportVesselName + " "
        supportVesselNameLabel.font = .systemFont(ofSize: 22)
        supportVesselNameLabel.textColor = .black
        supportVesselNameLabel.backgroundColor = .white
        supportVesselNameLabel.sizeToFit()
        supportVesselNameLabel.layer.opacity = 0.6
        supportVesselNameLabel.layer.cornerRadius = 10.0
        supportVesselNameLabel.clipsToBounds = true
        
        //SupportVesselService label settings
        supportVesselServiceLabel.text = "Service Record:"
        supportVesselServiceLabel.font = .boldSystemFont(ofSize: supportVesselServiceLabel.font.pointSize)
        supportVesselServiceLabel.sizeToFit()
        
        //SupportVesselYearsOfService label Settings
        var tempService: String = " " + String(currentVessel.yearJoinedSupportFleet)
        if(currentVessel.yearLeftSupportFleet == 0) {
            tempService += " - Present"
        }
        else if(currentVessel.yearJoinedSupportFleet != currentVessel.yearLeftSupportFleet) {
            tempService += " - " + String(currentVessel.yearLeftSupportFleet)
        }
        supportVesselYearsOfServiceLabel.text = tempService
        supportVesselYearsOfServiceLabel.sizeToFit()
        
        //SupportVesselStatus label setting
        supportVesselStatusLabel.text = "Status: "
        supportVesselStatusLabel.font = .boldSystemFont(ofSize: supportVesselStatusLabel.font.pointSize)
        supportVesselStatusLabel.sizeToFit()
        
        //SupportVesselOperationStatus label settings
        supportVesselOperationStatusLabel.text = " " + currentVessel.isActive + " "
        if(currentVessel.isActive == "Active") {
            supportVesselOperationStatusLabel.backgroundColor = .systemGreen
        } else {
            supportVesselOperationStatusLabel.backgroundColor = .systemRed
        }
        supportVesselOperationStatusLabel.sizeToFit()
        supportVesselOperationStatusLabel.layer.cornerRadius = 3.0
        supportVesselOperationStatusLabel.layer.masksToBounds = true
        
        //SupportVesselFlag label settings
        vesselFlagLabel.text = "Flag:"
        vesselFlagLabel.font = .boldSystemFont(ofSize: vesselFlagLabel.font.pointSize)
        vesselFlagLabel.sizeToFit()
        vesselFlagLabel.layoutIfNeeded()
        
        //SupportVesselCountryOfRegistration label settings
        supportVesselCountryOfRegistration.text = "🇺🇸"
        supportVesselCountryOfRegistration.sizeToFit()
        supportVesselCountryOfRegistration.layoutIfNeeded()
        
        homePortLabel.text = "Home Port:"
        homePortLabel.font = .boldSystemFont(ofSize: homePortLabel.font.pointSize)
        homePortLabel.sizeToFit()
        
        homePortLabelData.text = " " + currentVessel.portOfCalling
        homePortLabelData.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        supportVesselImageView.image = nil
        photographerTagLabel.text = nil
        supportVesselNameLabel.text = nil
        supportVesselYearsOfServiceLabel.text = nil
        supportVesselOperationStatusLabel.text = nil
        supportVesselOperationStatusLabel.backgroundColor = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(supportVesselImageView)
        contentView.addSubview(supportVesselBackgroundView)
        contentView.addSubview(photographerTagLabel)
        contentView.addSubview(supportVesselNameLabel)
        contentView.addSubview(supportVesselServiceLabel)
        contentView.addSubview(supportVesselYearsOfServiceLabel)
        contentView.addSubview(vesselFlagLabel)
        contentView.addSubview(supportVesselCountryOfRegistration)
        contentView.addSubview(supportVesselStatusLabel)
        contentView.addSubview(supportVesselOperationStatusLabel)
        contentView.addSubview(homePortLabel)
        contentView.addSubview(homePortLabelData)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        supportVesselImageView.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 190)
        
        supportVesselBackgroundView.frame = CGRect(x: 10, y: supportVesselImageView.frame.maxY, width: contentView.bounds.width - 20, height: 65)
        
        photographerTagLabel.frame.origin = CGPoint(x: supportVesselImageView.frame.maxX - photographerTagLabel.frame.width - 3, y: supportVesselImageView.frame.maxY - photographerTagLabel.frame.height - 3)
        
        supportVesselNameLabel.frame.origin = CGPoint(x: 15, y: 15)
        
        supportVesselServiceLabel.frame.origin = CGPoint(x: 15, y: 205)
        supportVesselYearsOfServiceLabel.frame.origin = CGPoint(x: supportVesselServiceLabel.frame.maxX, y: 205)
        
        vesselFlagLabel.frame.origin = CGPoint(x: contentView.bounds.width - vesselFlagLabel.frame.width - 15 - supportVesselCountryOfRegistration.frame.width, y: 205)
        supportVesselCountryOfRegistration.frame.origin = CGPoint(x: vesselFlagLabel.frame.maxX, y: 205)
        
        homePortLabel.frame.origin = CGPoint(x: 15, y: supportVesselServiceLabel.frame.maxY + 10)
        homePortLabelData.frame.origin = CGPoint(x: homePortLabel.frame.maxX, y: supportVesselServiceLabel.frame.maxY + 10)
        
        supportVesselStatusLabel.frame.origin = CGPoint(x: contentView.bounds.width - 15 - supportVesselStatusLabel.frame.width - supportVesselOperationStatusLabel.frame.width, y: vesselFlagLabel.frame.maxY + 10)
        supportVesselOperationStatusLabel.frame.origin = CGPoint(x: supportVesselStatusLabel.frame.maxX, y: vesselFlagLabel.frame.maxY + 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
