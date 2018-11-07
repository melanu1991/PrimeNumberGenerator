//
//  GeneratorViewController.swift
//  PrimeNumberGenerator
//
//  Created by Aliaksei Verameichyk on 11/5/18.
//  Copyright © 2018 Aliaksei Verameichyk. All rights reserved.
//

import UIKit

class GeneratorViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet private weak var upperNumberTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var executionTimeLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var presenter: GeneratorPresenterProtocol?
    private var primes: [UInt64]?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard(_ :)))
        view.addGestureRecognizer(tapGesture)
        
        tableView.tableFooterView = UIView()

        presenter = GeneratorPresenter(view: self)
    }
    
    // MARK: - Actions
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction private func generateButtonPressed(_ sender: UIButton) {
        guard let upperBoundString = upperNumberTextField.text, let upperBoundInteger = UInt64(upperBoundString) else {
            let alertController = UIAlertController(title: nil,
                                                    message: "Введите верхнюю границу",
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK",
                                            style: .default)
            alertController.addAction(alertAction)
            
            present(alertController,
                    animated: true)
            
            return
        }
        
        presenter?.generateAction(for: upperBoundInteger)
    }
    
    @IBAction private func clearCacheButtonPressed(_ sender: UIBarButtonItem) {
        presenter?.clearCacheAction()
    }
}

// MARK: - Implementation UITableViewDataSource

extension GeneratorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return primes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: "GeneratorCellIdentifier")
        
        if let prime = primes?[indexPath.row] {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.text = "\(prime)"
        }
        
        return cell
    }
}

// MARK: - Implementation GeneratorViewControllerProtocol

extension GeneratorViewController: GeneratorViewControllerProtocol {
    func display(_ primes: [UInt64]) {
        self.primes = primes
        
        tableView.reloadData()
    }
    
    func display(_ executionTime: String) {
        executionTimeLabel.text = "Время выполнения: \(executionTime)"
        
        upperNumberTextField.resignFirstResponder()
    }
    
    func showHud() {
        activityIndicatorView.startAnimating()
    }
    
    func hideHud() {
        activityIndicatorView.stopAnimating()
    }
}
