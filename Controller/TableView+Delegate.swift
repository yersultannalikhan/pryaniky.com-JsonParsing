//
//  TableView+Delegate.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import UIKit

extension TableViewController: SegmentedControlValueChangedProtocol {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(indexPath: indexPath)
    }
    
    func valueChanged(data: SelectorData, selectedIndex: Int) {
        viewModel?.segmentedControlValueChanged(index: selectedIndex)
    }
}


