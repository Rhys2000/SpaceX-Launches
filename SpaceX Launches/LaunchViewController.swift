//
//  ViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/4/22.
//

import UIKit

class LaunchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
    
    let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var launchCollectionView: UICollectionView?
    let searchController = UISearchController()

    var launchData = LaunchLoader().allLaunches
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchData = launchData.reversed()
        
        //SearchBar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All"]
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.enablesReturnKeyAutomatically = false

        //Create collectionViewLayout parameters and set launchCollectionView attributes
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionViewLayout.itemSize = CGSize(width: 175, height: 300)
        launchCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        view.addSubview(launchCollectionView!)
        
        launchCollectionView!.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.identifier)
        launchCollectionView!.delegate = self
        launchCollectionView!.dataSource = self
        launchCollectionView!.keyboardDismissMode = .onDrag
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = launchCollectionView!.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier, for: indexPath) as? LaunchCollectionViewCell else { return UICollectionViewCell() }
        cell.createLaunchPreview(with: launchData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        let searchText = searchController.searchBar.text!
        
        filterUsingSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterUsingSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        launchData = launchData.filter {
            launch in
            let scopeMatch = (scopeButton == "All")
            if(searchController.searchBar.text != "") {
                let searchTextMatch = launch.abbreviatedLaunchName.lowercased().hasPrefix(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        launchCollectionView!.reloadData()
    }
}

