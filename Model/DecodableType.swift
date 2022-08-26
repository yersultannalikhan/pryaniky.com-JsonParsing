//
//  Decodable.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 25.08.2022.
//

import Foundation

class DecodableType: Decodable {
    var data: [ElementData]
    var view: [String]
    
    private enum CodingKeys: String, CodingKey {
        case data
        case view
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        view = try values.decode([String].self, forKey: .view)
        data = try values.decode([ElementData].self, forKey: .data)
    }
}

class ElementData: Decodable {
    var name: String
    var data: MyData
    
    private enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        data = try values.decode(MyData.self, forKey: .data)
    }
}

enum MyData: Decodable {
    case selector(SelectorData)
    case text(TextData)
    case image(ImageData)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let image = try? container.decode(ImageData.self) {
            self = .image(image)
            return
        }
        if let text = try? container.decode(TextData.self) {
            self = .text(text)
            return
        }
        if let selector = try? container.decode(SelectorData.self) {
            self = .selector(selector)
            return
        }
        throw DecodingError.typeMismatch(MyData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyData"))
    }
    
    func associatedValue() -> Any {
        switch self {
        case .text(let value):
            return value
        case .image(let value):
            return value
        case .selector(let value):
            return value
        }
    }
}

class TextData: Decodable {
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
    }
}

class ImageData: Decodable {
    var url: String
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case url
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
        text = try values.decode(String.self, forKey: .text)
    }
    
}

class SelectorData: Decodable {
    var selectedId: Int
    var variants: [SelectorDetailData]
    
    private enum CodingKeys: String, CodingKey {
        case selectedId
        case variants
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selectedId = try values.decode(Int.self, forKey: .selectedId)
        variants = try values.decode([SelectorDetailData].self, forKey: .variants)
    }
}

class SelectorDetailData: Decodable {
    var id: Int
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
    }
}
