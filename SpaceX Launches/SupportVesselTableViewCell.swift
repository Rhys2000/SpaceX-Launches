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
        photographerTagLabel.text = " PC: " + currentVessel.photographerCredit + " "
        photographerTagLabel.backgroundColor = .brown
        photographerTagLabel.font = .systemFont(ofSize: 10)
        photographerTagLabel.sizeToFit()
        photographerTagLabel.layoutIfNeeded()
        photographerTagLabel.layer.cornerRadius = 3.0
        photographerTagLabel.layer.masksToBounds = true
        
        //SupportVesselName label settings
        supportVesselNameLabel.text = currentVessel.supportVesselName
        supportVesselNameLabel.sizeToFit()
        supportVesselNameLabel.layoutIfNeeded()
        
        //SupportVesselService label settings
        supportVesselServiceLabel.text = "Service Record:"
        supportVesselServiceLabel.font = .boldSystemFont(ofSize: supportVesselServiceLabel.font.pointSize)
        supportVesselServiceLabel.sizeToFit()
        supportVesselServiceLabel.layoutIfNeeded()
        
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
        supportVesselYearsOfServiceLabel.layoutIfNeeded()
        
        //SupportVesselStatus label setting
        supportVesselStatusLabel.text = "Status: "
        supportVesselStatusLabel.font = .boldSystemFont(ofSize: supportVesselStatusLabel.font.pointSize)
        supportVesselStatusLabel.sizeToFit()
        supportVesselStatusLabel.layoutIfNeeded()
        
        //SupportVesselOperationStatus label settings
        supportVesselOperationStatusLabel.text = " " + currentVessel.isActive + " "
        if(currentVessel.isActive == "Active") {
            supportVesselOperationStatusLabel.backgroundColor = .green
        } else {
            supportVesselOperationStatusLabel.backgroundColor = .red
        }
        supportVesselOperationStatusLabel.sizeToFit()
        supportVesselOperationStatusLabel.layoutIfNeeded()
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
        contentView.addSubview(supportVesselStatusLabel)
        contentView.addSubview(supportVesselOperationStatusLabel)
        contentView.addSubview(vesselFlagLabel)
        contentView.addSubview(supportVesselCountryOfRegistration)
        //contentView.backgroundColor = .orange
    }
    
    override func layoutSubviews() { //FIX THE SPACING OF THE TEXT LABELS IN THE UIVIEW
        super.layoutSubviews()
        supportVesselImageView.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 190)
        supportVesselBackgroundView.frame = CGRect(x: 10, y: supportVesselImageView.frame.maxY, width: contentView.bounds.width - 20, height: 65)
        photographerTagLabel.frame = CGRect(x: 15, y: 15, width: photographerTagLabel.frame.width, height: photographerTagLabel.frame.height)
        supportVesselNameLabel.frame = CGRect(x: 15, y: 205, width: supportVesselNameLabel.frame.width, height: supportVesselNameLabel.frame.height)
        
        supportVesselServiceLabel.frame = CGRect(x: 15, y: supportVesselNameLabel.frame.maxY + 10, width: supportVesselServiceLabel.frame.width, height: supportVesselServiceLabel.frame.height)
        supportVesselYearsOfServiceLabel.frame = CGRect(x: supportVesselServiceLabel.frame.maxX, y: supportVesselNameLabel.frame.maxY + 10, width: supportVesselYearsOfServiceLabel.frame.width, height: supportVesselYearsOfServiceLabel.frame.height)
        
        supportVesselOperationStatusLabel.frame = CGRect(x: 375 - supportVesselOperationStatusLabel.frame.width, y: 205, width: supportVesselOperationStatusLabel.frame.width, height: supportVesselOperationStatusLabel.frame.height)
        supportVesselStatusLabel.frame = CGRect(x: supportVesselOperationStatusLabel.frame.origin.x - supportVesselStatusLabel.frame.width, y: 205, width: supportVesselStatusLabel.frame.width, height: supportVesselStatusLabel.frame.height)
        
        supportVesselCountryOfRegistration.frame = CGRect(x: 375 - supportVesselCountryOfRegistration.frame.width, y: supportVesselNameLabel.frame.maxY + 10, width: supportVesselCountryOfRegistration.frame.width, height: supportVesselCountryOfRegistration.frame.height)
        vesselFlagLabel.frame = CGRect(x: supportVesselCountryOfRegistration.frame.origin.x - vesselFlagLabel.frame.width, y: supportVesselNameLabel.frame.maxY + 10, width: vesselFlagLabel.frame.width, height: vesselFlagLabel.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
