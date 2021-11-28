//
//  Owner.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 23.11.2021.
//

import Foundation

struct Owner: Codable {
    let reputation, userID: Int?
    let profileImage: String?
    let displayName: String
    let link: String?
    let acceptRate: Int?

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
        case acceptRate = "accept_rate"
    }
}
