//
//  SupportVesselDetailViewAboutViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 9/7/22.
//

import UIKit

class SupportVesselDetailViewAboutViewController: UIViewController {
    
    static let identifier = "SupportVesselDetailViewAboutViewController"
    
    var vesselName = String()
    var stringArray = [String]()
    private let scrollView = UIScrollView()
    private let backgroundView = UIView()
    private let aboutLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = vesselName
        
        view.addSubview(scrollView)
        
        backgroundView.backgroundColor = .gray
        backgroundView.layer.cornerRadius = 10.0
        scrollView.addSubview(backgroundView)
        
        aboutLabel.text = ""
        for paragraph in stringArray {
            if(paragraph != stringArray.last) {
                aboutLabel.text! += paragraph + "\n\n"
            } else {
                aboutLabel.text! += paragraph
            }
        }
        aboutLabel.numberOfLines = 0
        backgroundView.addSubview(aboutLabel)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        
        backgroundView.frame = CGRect(x: 10, y: 0, width: scrollView.frame.width - 20, height: 100)
        
        let aboutLabelSize = updateFrame(for: aboutLabel, using: backgroundView)
        aboutLabel.frame = CGRect(x: 10, y: 10, width: aboutLabelSize.width, height: aboutLabelSize.height)
        
        backgroundView.frame = CGRect(x: 10, y: 10, width: scrollView.frame.width - 20, height: aboutLabel.frame.maxY + 10)
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: backgroundView.frame.maxY + 10)
    }
    
    func updateFrame(for label: UILabel, using view: UIView) -> CGSize {
        let maxSize = CGSize(width: view.bounds.width - 20, height: 1000)
        return label.sizeThatFits(maxSize)
    }

}
