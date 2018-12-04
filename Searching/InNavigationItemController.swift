//
//  InNavigationItemViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

class InNavigationItemController: UIViewController {
    var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number?"
        
        return label
    }()

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "In Nav Item"
        definesPresentationContext = true

        setUpView()
        setUpResultLabel()
        setUpSearchController()
        setUpSearchInterface()
    }
    
    func setUpView() {
        view.backgroundColor = UIColor.white
    }
    
    func setUpResultLabel() {
        view.addSubview(resultLabel)
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpSearchController() {
        let resultsController = ResultsTableViewController()
        resultsController.onTapHandler = { result in
            self.resultLabel.text = result
            self.searchController.isActive = false
        }
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = resultsController
        searchController.searchBar.sizeToFit()
    }
    
    func setUpSearchInterface() {
        navigationItem.searchController = searchController
    }
}
