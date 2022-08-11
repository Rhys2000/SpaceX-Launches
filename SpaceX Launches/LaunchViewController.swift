//
//  LaunchViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/8/22.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var launchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        launchCollectionView.dataSource = self
        launchCollectionView.delegate = self
        launchCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        launchCollectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        launchCollectionView.backgroundColor = .purple
    }
}

extension LaunchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = launchCollectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCollectionViewCell", for: indexPath) as! LaunchCollectionViewCell
        cell.createLaunchPreview(with: launches[indexPath.row])
        return cell
    }
}

extension LaunchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 300)
    }
}

extension LaunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LaunchDetailViewController") as? LaunchDetailViewController
        vc?.currentLaunch = launches[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
