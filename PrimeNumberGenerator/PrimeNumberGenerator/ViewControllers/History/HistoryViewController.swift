//
//  HistoryViewController.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: HistoryViewViewModel?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let histories = CoreDataManager.shared.fetchHistories() {
            viewModel = HistoryViewViewModel(models: histories)
        }
        
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Implementation UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1,
                                   reuseIdentifier: "HistoryCellIdentifier")
        
        if let viewModel = viewModel {
            cell.textLabel?.text = viewModel.upperBound(for: indexPath.row)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            
            cell.detailTextLabel?.text = viewModel.executionTime(for: indexPath.row)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        }
        
        return cell
    }
}
