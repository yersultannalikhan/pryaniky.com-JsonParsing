//
//  ViewController.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: TableViewModelType?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "List from server"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.reuseIdentifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        
        viewModel = TableViewModel()

        viewModel?.data?.bind(listener: { value in
            if value != nil {
                self.tableView.reloadData()
            }
        })
        
        viewModel?.message?.bind(listener: { message in
            if !message.isEmpty {
                let alertController = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel)
                alertController.addAction(action)
                self.present(alertController, animated: true)
            }
        })

    }

}

