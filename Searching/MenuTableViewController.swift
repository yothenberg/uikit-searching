//
//  MenuTableViewController.swift
//  Searching
//
//  Created by Mark Wright on 12/3/18.

import UIKit

class DetailCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum Cells: Int, CaseIterable {
    case inNav = 0
    case inTableHeader
    case inContainer
    case manual
}

class MenuTableViewController: UITableViewController {
    let cellReuseIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Searching"
        self.tableView.register(DetailCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cells.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)

        if indexPath.row == Cells.inNav.rawValue {
            cell.textLabel?.text = "Navigation Item"
            cell.detailTextLabel?.text = "Using a UISearchController with the search bar inside a UINavigationItem"
        } else if indexPath.row == Cells.inTableHeader.rawValue {
            cell.textLabel?.text = "Table Header"
            cell.detailTextLabel?.text = "Using a UISearchController with the search bar inside a UITableView.tableHeaderView"
        } else if indexPath.row == Cells.inContainer.rawValue {
            cell.textLabel?.text = "Container View"
            cell.detailTextLabel?.text = "Using a UISearchController with the search bar inside a regular UIView"
        } else if indexPath.row == Cells.manual.rawValue {
            cell.textLabel?.text = "Without a UISearchController"
            cell.detailTextLabel?.text = "Using a UISearchBar directly gives you complete control over what happens"
        } else {
            preconditionFailure("Only expect three rows in the table")
        }

        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == Cells.inNav.rawValue {
            let vc = InNavigationItemController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == Cells.inTableHeader.rawValue {
            let vc = InTableHeaderViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == Cells.inContainer.rawValue {
            let vc = InContainerViewController()
            self.present(vc, animated: true, completion: nil)
        } else if indexPath.row == Cells.manual.rawValue {
            let vc = ManualViewController()
            self.present(vc, animated: true, completion: nil)
        } else {
            preconditionFailure("Only expect three rows in the table")
        }
    }
}
