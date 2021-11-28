//
//  Answer.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 25.11.2021.
//

import Foundation

struct Answer: Codable, Identifiable {
    let id: Int
    let questionId: Int
    let body: String
    let score: Int

    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case questionId = "question_id"
        case score
        case body
    }
}

