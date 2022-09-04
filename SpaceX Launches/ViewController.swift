//
//  ViewController.swift
//  SpaceX Launches
//
//  Created by Rhys Julian-Jones on 8/4/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let supportVesselTableView = UITableView()
    let searchController = UISearchController()
    
    let supportVesselData = SupportVesselLoader().allSupportVessels
    var filteredSupportVesselData = [SupportVessel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchBar
        title = "Support Vessels"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All", "Active", "Retired"]
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.enablesReturnKeyAutomatically = true
        
        //TableView
        view.addSubview(supportVesselTableView)
        supportVesselTableView.register(SupportVesselTableViewCell.self, forCellReuseIdentifier: SupportVesselTableViewCell.identifier)
        supportVesselTableView.delegate = self
        supportVesselTableView.dataSource = self
        
        supportVesselTableView.separatorStyle = .none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        supportVesselTableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return filteredSupportVesselData.count
        } else {
            return supportVesselData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = supportVesselTableView.dequeueReusableCell(withIdentifier: SupportVesselTableViewCell.identifier, for: indexPath) as? SupportVesselTableViewCell else { return UITableViewCell() }
        if(searchController.isActive) {
            cell.textLabel?.text = filteredSupportVesselData[indexPath.row].supportVesselName
            cell.createSupportVesselPreview(with: filteredSupportVesselData[indexPath.row])
        } else {
            cell.textLabel?.text = supportVesselData[indexPath.row].supportVesselName
            cell.createSupportVesselPreview(with: supportVesselData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searchController.isActive) {
            print(filteredSupportVesselData[indexPath.row].yearJoinedSupportFleet)
        } else {
            print(supportVesselData[indexPath.row].yearJoinedSupportFleet)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        let searchText = searchController.searchBar.text!
        
        filterUsingSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterUsingSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        filteredSupportVesselData = supportVesselData.filter {
            vessel in
            let scopeMatch = (scopeButton == "All" || vessel.isActive == scopeButton)
            if(searchController.searchBar.text != "") {
                let searchTextMatch = vessel.supportVesselName.lowercased().hasPrefix(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        supportVesselTableView.reloadData()
    }
    
}

