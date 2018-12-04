//
//  BareControllerViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

/**
 Uses a UISearchController and displays the UISearchBar in a container
 view. The important part to remember is that you shouldn't constrain
 the UISearchBar directly because the UISearchController removes it from
 it's original superview in order to display it within the presented
 results controller. So constraints on the UISearchBar will break.
 Wrap the UISearchBar within a container view and constrain that.
 
 There still remains the problem that UISearchController does not move
 the UISearchBar to the top of the screen (if it isn't in a tableView)
 automatically. UISearchController also presents the results controller
 modally so it obscures anything behind it.
 */
class InContainerViewController: UIViewController {
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result?"
        label.textAlignment = .center
        
        return label
    }()

    var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("done", for: .normal)
        button.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
        return button
    }()
    
    var searchBarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    var searchControllerOne: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true
        
        setUpView()
        setUpResultLabel()
        setUpDoneButton()
        setUpSearchController()
        setUpSearchInterface()
    }
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    func setUpResultLabel() {
        view.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 16.0).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func setUpSearchController() {
        let resultsControllerOne = ResultsTableViewController()
        resultsControllerOne.onTapHandler = { result in
            self.resultLabel.text = result
            self.searchControllerOne.isActive = false
        }
        searchControllerOne = UISearchController(searchResultsController: resultsControllerOne)
        searchControllerOne.searchResultsUpdater = resultsControllerOne
        searchControllerOne.dimsBackgroundDuringPresentation = false
        searchControllerOne.searchBar.sizeToFit()
    }

    func setUpSearchInterface() {
        searchBarContainerView.addSubview(searchControllerOne.searchBar)

        let searchTitle = UILabel()
        searchTitle.text = "Search using the box below"
        searchTitle.backgroundColor = .green
        searchTitle.textColor = .white
        searchTitle.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [searchTitle, searchBarContainerView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
    @objc func done(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
