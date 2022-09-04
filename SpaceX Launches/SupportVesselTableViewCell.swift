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
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(supportVesselImageView)
        contentView.addSubview(supportVesselBackgroundView)
        contentView.backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        supportVesselImageView.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 190)
        supportVesselBackgroundView.frame = CGRect(x: 10, y: supportVesselImageView.frame.maxY, width: contentView.bounds.width - 20, height: 65)
        print(supportVesselImageView.frame.maxY)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
