//
//  File.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import Foundation

struct Question: Codable, Identifiable {
    var id = UUID()
    let questionId: Int
    let title: String
    let body: String
    let score: Int
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case title
        case score
        case body
        case owner
    }
}

