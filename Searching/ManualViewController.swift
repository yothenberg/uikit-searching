//
//  ManualViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

class ManualViewController: UIViewController {
    var resultLabelOne: UILabel = {
        let label = UILabel()
        label.text = "Result 1?"
        label.textAlignment = .center
        
        return label
    }()

    var resultLabelTwo: UILabel = {
        let label = UILabel()
        label.text = "Result 2?"
        label.textAlignment = .center
        
        return label
    }()

    var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("done", for: .normal)
        button.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
        return button
    }()
    
    /// Contains the search bars and labels
    var searchContainerView: UIStackView!
    /// Contains the result labels
    var resultsStackView: UIStackView!
    /// The results controller for the first search bar
    var resultsControllerOne: ResultsTableViewController!
    /// The first search bar
    var searchBarOne: UISearchBar!
    /// The results controller for the second search bar
    var resultsControllerTwo: ResultsTableViewController!
    /// The second search bar
    var searchBarTwo: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpResultLabels()
        setUpDoneButton()
        setUpSearchControllers()
        setUpSearchInterface()
        setUpResultsInterface()
    }
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    /**
     Add the result labels to a stack view and constrain the stack view
     to the center of the main view
     */
    func setUpResultLabels() {
        resultsStackView = UIStackView(arrangedSubviews: [resultLabelOne, resultLabelTwo])
        resultsStackView.axis = .vertical
        view.addSubview(resultsStackView)
        
        resultsStackView.translatesAutoresizingMaskIntoConstraints = false
        resultsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    /**
     Add the done button to the main view and constrain it just below the stack view
     containing the result labels
     */
    func setUpDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.topAnchor.constraint(equalTo: resultsStackView.bottomAnchor, constant: 16.0).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /**
     Add the result controllers as child view controllers and add their table views
     as subviews. By default the table views are hidden.
     */
    func setUpSearchControllers() {
        resultsControllerOne = ResultsTableViewController()
        resultsControllerOne.results = (1...50).map { String(describing:$0) }
        resultsControllerOne.onTapHandler = { result in
            self.resultLabelOne.text = result
            self.searchBarOne.text = ""
            self.searchBarOne.resignFirstResponder()
        }
        addChild(resultsControllerOne)
        view.addSubview(resultsControllerOne.view)
        resultsControllerOne.didMove(toParent: self)
        resultsControllerOne.view.isHidden = true
        resultsControllerOne.view.translatesAutoresizingMaskIntoConstraints = false

        resultsControllerTwo = ResultsTableViewController()
        resultsControllerTwo.results = (51...100).map { String(describing:$0) }
        resultsControllerTwo.onTapHandler = { result in
            self.resultLabelTwo.text = result
            self.searchBarTwo.text = ""
            self.searchBarTwo.resignFirstResponder()
        }
        addChild(resultsControllerTwo)
        view.addSubview(resultsControllerTwo.view)
        resultsControllerTwo.didMove(toParent: self)
        resultsControllerTwo.view.isHidden = true
        resultsControllerTwo.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Add two labels and two search bars to a stack view. Constrain the stack view
     to the top of the main view.
     */
    func setUpSearchInterface() {
        let searchTitle = UILabel()
        searchTitle.text = "Search for numbers"
        searchTitle.backgroundColor = .blue
        searchTitle.textColor = .white
        searchTitle.textAlignment = .center

        let searchAnd = UILabel()
        searchAnd.text = "For fun"
        searchAnd.backgroundColor = .blue
        searchAnd.textColor = .white
        searchAnd.textAlignment = .center

        searchBarOne = UISearchBar()
        searchBarOne.placeholder = "First number between 1 - 50"
        searchBarOne.sizeToFit()
        searchBarOne.delegate = self

        searchBarTwo = UISearchBar()
        searchBarTwo.placeholder = "Second number between 51 - 100"
        searchBarTwo.sizeToFit()
        searchBarTwo.delegate = self

        searchContainerView = UIStackView(arrangedSubviews: [searchTitle, searchBarOne, searchAnd, searchBarTwo])
        searchContainerView.axis = .vertical
        searchContainerView.distribution = .fillEqually
        view.addSubview(searchContainerView)
        
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchContainerView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }

    /**
     Constrain the result controller's table views' so that when they appear
     they are pinned underneath the searchContainerView and extend to the
     bottom of the main view.
     */
    func setUpResultsInterface() {
        let resultsViewOne = resultsControllerOne.view!
        resultsViewOne.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor).isActive = true
        resultsViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultsViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultsViewOne.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let resultsViewTwo = resultsControllerTwo.view!
        resultsViewTwo.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor).isActive = true
        resultsViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultsViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resultsViewTwo.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func done(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ManualViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let activeResultsController = (searchBar == searchBarOne ? resultsControllerOne : resultsControllerTwo)!
        
        activeResultsController.updateSearchResults(for: searchText)
        view.bringSubviewToFront(activeResultsController.view)
        activeResultsController.view.isHidden = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        let activeResultsController = (searchBar == searchBarOne ? resultsControllerOne : resultsControllerTwo)!
        activeResultsController.view.isHidden = true
    }
}
