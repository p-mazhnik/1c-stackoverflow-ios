//
//  ListResponse.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 28.11.2021.
//

import Foundation

struct ListResponse<T : Codable>: Codable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}

