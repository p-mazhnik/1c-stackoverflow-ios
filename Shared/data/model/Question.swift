//
//  File.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import Foundation
import CoreData

struct Question: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String?
    let score: Int?
    let owner: Owner?

    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
        case score
        case body
        case owner
    }
}

extension Question {
    
    init(managedObject: QuestionMO) {
        let title = managedObject.title!
        let id = managedObject.id!
        
        self.init(id: Int(id) ?? 0, title: title, body: nil, score: nil, owner: nil)
    }
}
