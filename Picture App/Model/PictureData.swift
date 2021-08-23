//
//  PictureData.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import Foundation

struct PictureData: Codable {
    let altDescription: String?
    let urls: Urls
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case altDescription = "alt_description"
        case urls
        case id
    }
}

struct Urls: Codable {
    let regular: String
}

