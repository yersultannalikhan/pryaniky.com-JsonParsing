//
//  SelectorCell.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import UIKit

protocol SegmentedControlValueChangedProtocol {
    func valueChanged(data: SelectorData, selectedIndex: Int)
}

class SelectorCell: UITableViewCell {
    
    var data: SelectorData? {
        didSet {
            guard let data = data else { return }
            var items = [String]()
            data.variants.forEach {
                items.append($0.text)
                self.segmentedControl.setTitle($0.text, forSegmentAt: ($0.id-1))
            }
            self.segmentedControl.selectedSegmentIndex = (data.selectedId-1)
        }
    }
    
    var delegate: SegmentedControlValueChangedProtocol?
    
    static let reuseIdentifier = "selectorCell"
    
    var segmentedControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["1", "2", "3"])
        sg.isUserInteractionEnabled = true
        sg.selectedSegmentIndex = 0
        
        return sg
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(segmentedControl)
    }
    
    func setupConstraints() {
        segmentedControl.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 12, bottom: 6, right: 12))
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let data = data else { return }
        delegate?.valueChanged(data: data, selectedIndex: sender.selectedSegmentIndex)
    }
}
