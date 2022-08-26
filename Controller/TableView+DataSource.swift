//
//  TableView+DataSource.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import UIKit


extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cellType = viewModel.cellTypeForRowAt(indexPath: indexPath) else {
            return UITableViewCell()
        }
        if cellType == .text {
            let data = viewModel.textModelForRow(cellType: cellType)
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data?.text
            cell.selectionStyle = .none
            return cell
        } else if cellType == .image {
            let data = viewModel.imageModelForRow(cellType: cellType)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return UITableViewCell() }
            cell.data = data
            cell.selectionStyle = .none
            return cell
        } else {
            let data = viewModel.selectorModelForRow(cellType: cellType)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.reuseIdentifier, for: indexPath) as? SelectorCell else { return UITableViewCell() }
            cell.data = data
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
