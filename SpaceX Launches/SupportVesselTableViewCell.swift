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
        if(currentVessel.photographerCredit != "") {
            photographerTagLabel.text = " PC: " + currentVessel.photographerCredit + " "
        }
        photographerTagLabel.backgroundColor = .brown
        photographerTagLabel.font = .systemFont(ofSize: 10)
        photographerTagLabel.sizeToFit()
        photographerTagLabel.layoutIfNeeded()
        
        //SupportVesselName label settings
        supportVesselNameLabel.text = "Vessel: " + currentVessel.supportVesselName
        supportVesselNameLabel.sizeToFit()
        supportVesselNameLabel.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        supportVesselImageView.image = nil
        photographerTagLabel.text = nil
        supportVesselNameLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(supportVesselImageView)
        contentView.addSubview(supportVesselBackgroundView)
        if(photographerTagLabel.frame.width < 26) {
            contentView.addSubview(photographerTagLabel)
        }
        contentView.addSubview(supportVesselNameLabel)
        contentView.backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        supportVesselImageView.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 190)
        supportVesselBackgroundView.frame = CGRect(x: 10, y: supportVesselImageView.frame.maxY, width: contentView.bounds.width - 20, height: 65)
        photographerTagLabel.frame = CGRect(x: 15, y: 15, width: photographerTagLabel.frame.width, height: photographerTagLabel.frame.height)
        supportVesselNameLabel.frame = CGRect(x: 15, y: 205, width: supportVesselNameLabel.frame.width, height: supportVesselNameLabel.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
