//
//  DataModel.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 26.05.2022.
//

import Foundation

struct DataModel: Decodable {
    let data: [DataBlock]
    let view: [String]
}

struct DataBlock: Decodable {
    let name: String
    let data: Content
}

struct Content: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
