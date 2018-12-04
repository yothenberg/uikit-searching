//
//  InHeaderViewTableViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

class InTableHeaderViewController: UITableViewController {
    private let cellReuseIdentifier = "Cell"
    var items = [String]()
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "In Table Header"
        definesPresentationContext = true
        
        setUpTable()
        setUpData()
        setUpSearchController()
        setUpSearchInterface()
    }

    func setUpTable() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
    }

    func setUpData() {
        items = ["1", "22", "44"]
    }
    
    func setUpSearchController() {
        let resultsController = ResultsTableViewController()
        resultsController.onTapHandler = { result in
            self.items.append(result)
            self.searchController.isActive = false
            self.tableView.reloadData()
        }
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.sizeToFit()
    }
    
    func setUpSearchInterface() {
        tableView.tableHeaderView = searchController.searchBar
    }
}

// MARK: - UITableViewDataSource
extension InTableHeaderViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
}

