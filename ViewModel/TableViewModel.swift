//
//  TableViewModel.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import Foundation
import Alamofire
import SwiftUI

class TableViewModel: TableViewModelType {
    
    var data: Box<DecodableType?>? = Box(nil)
    var message: Box<String>? = Box("")
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        AF.request("https://pryaniky.com/static/json/sample.json").responseDecodable(of: DecodableType.self) { response in
            guard let values = response.value else { return }
            self.data?.value = values
        }
    }
    
    func numberOfRows() -> Int {
        return data?.value?.view.count ?? 0
    }
    
    func cellTypeForRowAt(indexPath: IndexPath) -> CellType? {
        guard let current = data?.value?.view[indexPath.row] else {
            return nil
        }
        return CellType(rawValue: current)
    }
    
    func textModelForRow(cellType: CellType) -> TextData? {
        let selectedElementData = data?.value?.data.filter({ element in
            element.name == cellType.rawValue
        })
        guard let elementData = selectedElementData?.first?.data else { return nil }
        guard let data = elementData.associatedValue() as? TextData else { return nil }
        return data
    }
    
    func imageModelForRow(cellType: CellType) -> ImageData? {
        let selectedElementData = data?.value?.data.filter({ element in
            element.name == cellType.rawValue
        })
        guard let elementData = selectedElementData?.first?.data else { return nil }
        guard let data = elementData.associatedValue() as? ImageData else { return nil }
        return data
    }
    
    func selectorModelForRow(cellType: CellType) -> SelectorData? {
        let selectedElementData = data?.value?.data.filter({ element in
            element.name == cellType.rawValue
        })
        guard let elementData = selectedElementData?.first?.data else { return nil }
        guard let data = elementData.associatedValue() as? SelectorData else { return nil }
        return data
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let cellType = cellTypeForRowAt(indexPath: indexPath) else { return }
        if cellType == .text {
            if let textData = textModelForRow(cellType: cellType) {
                message?.value = "name: \(cellType.rawValue), text: \(textData.text)"
            }
        } else if cellType == .image {
            if let imageData = imageModelForRow(cellType: cellType) {
                message?.value = "name: \(cellType.rawValue), text: \(imageData.text)"
            }
        } else {
            if let selectorData = selectorModelForRow(cellType: cellType) {
                message?.value = "name: \(cellType.rawValue), initial selectedID: \(selectorData.selectedId-1)"
            }
        }
    }
    
    func segmentedControlValueChanged(index: Int) {
        let cellType = CellType.selector
        if let selectorData = selectorModelForRow(cellType: cellType) {
            let text = selectorData.variants[index].text
            message?.value = "name: \(cellType.rawValue), selectedID changed: \(index), variant name \(text)"
        }
    }
}
