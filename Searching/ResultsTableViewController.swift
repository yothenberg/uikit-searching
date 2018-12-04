//
//  ResultsTableViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

protocol SearchResultsUpdating {
    func updateSearchResults(for searchTerm: String)
}

class ResultsTableViewController: UITableViewController {
    private let cellReuseIdentifier = "Cell"
    private var filteredResults = [String]()
    var results:[String]?
    var onTapHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setUpData()
    }
    
    func setUpTable() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
    }
    
    func setUpData() {
        if results == nil {
            results = (1...100).map { String(describing:$0) }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        let string = filteredResults[indexPath.row]
        cell.textLabel?.text = string
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = filteredResults[indexPath.row]
        
        onTapHandler?(result)
    }
}

extension ResultsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let target = searchBar.text!
        updateSearchResults(for: target)
    }
}

extension ResultsTableViewController: SearchResultsUpdating {
    func updateSearchResults(for searchTerm: String) {
        guard let results = self.results else {
            preconditionFailure("expecting results")
        }
        
        self.filteredResults = results.filter { s in
            let found = s.range(of:searchTerm, options: .caseInsensitive)
            return (found != nil)
        }
        
        self.tableView.reloadData()
    }
}
