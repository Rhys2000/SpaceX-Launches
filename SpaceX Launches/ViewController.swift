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
    
    var supportVesselData = SupportVesselLoader().allSupportVessels
    var filteredSupportVesselData = [SupportVessel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchBar
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let topButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.circle"), style: .plain, target: self, action: #selector(returnToTop(sender:)))
        topButton.tintColor = .white
        let bottomButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down.circle"), style: .plain, target: self, action: #selector(returnToBottom(sender:)))
        bottomButton.tintColor = .white
        navigationItem.leftBarButtonItems = [topButton, bottomButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle"), style: .plain, target: self, action: #selector(sortArrayAlphabetically(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All", "Active", "Retired"]
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.enablesReturnKeyAutomatically = false
        
        //TableView
        view.addSubview(supportVesselTableView)
        supportVesselTableView.register(SupportVesselTableViewCell.self, forCellReuseIdentifier: SupportVesselTableViewCell.identifier)
        supportVesselTableView.delegate = self
        supportVesselTableView.dataSource = self
        supportVesselTableView.keyboardDismissMode = .onDrag
        
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
            cell.createSupportVesselPreview(with: filteredSupportVesselData[indexPath.row])
        } else {
            cell.createSupportVesselPreview(with: supportVesselData[indexPath.row])
        }
        return cell
    }
    
    
    
    
    //First step will be adding a new tab into the tab bar controller and placing all of this data onto a new view controller
    
    
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
    
    @objc func returnToTop(sender: UIBarButtonItem) {
        supportVesselTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func returnToBottom(sender: UIBarButtonItem) {
        if(searchController.isActive) {
            supportVesselTableView.scrollToRow(at: IndexPath(row: filteredSupportVesselData.count - 1, section: 0), at: .bottom, animated: true)
        } else {
            supportVesselTableView.scrollToRow(at: IndexPath(row: supportVesselData.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    var sortingButtonState: Int = 0
    @objc func sortArrayAlphabetically(sender: UIBarButtonItem) {
        if(searchController.isActive) {
            if(sortingButtonState % 2 == 0) {
                filteredSupportVesselData = filteredSupportVesselData.sorted {
                    $0.supportVesselName < $1.supportVesselName
                }
                sortingButtonState = 1
            } else {
                filteredSupportVesselData = filteredSupportVesselData.sorted {
                    $0.supportVesselName > $1.supportVesselName
                }
                sortingButtonState = 0
            }
        } else {
            if(sortingButtonState % 2 == 0) {
                supportVesselData = supportVesselData.sorted {
                    $0.supportVesselName < $1.supportVesselName
                }
                sortingButtonState = 1
            } else {
                supportVesselData = supportVesselData.sorted {
                    $0.supportVesselName > $1.supportVesselName
                }
                sortingButtonState = 0
            }
        }
        supportVesselTableView.reloadData()
    }
    
}

