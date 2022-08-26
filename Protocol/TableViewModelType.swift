//
//  TableViewModelType.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import Foundation
import UIKit

protocol TableViewModelType {

    var data: Box<DecodableType?>? { get }
    var message: Box<String>? { get }
    
    func fetchData()
    
    func numberOfRows() -> Int
    func cellTypeForRowAt(indexPath: IndexPath) -> CellType?
    func textModelForRow(cellType: CellType) -> TextData?
    func imageModelForRow(cellType: CellType) -> ImageData?
    func selectorModelForRow(cellType: CellType) -> SelectorData?
    func didSelectRowAt(indexPath: IndexPath)
    func segmentedControlValueChanged(index: Int)
}

enum CellType: String {
    case text = "hz"
    case image = "picture"
    case selector = "selector"
}
