//
//  SOListViewModel.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import Foundation
import Combine

class SOListViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    var cancellationToken: AnyCancellable?
    
    init() {
        getQuestions()
    }
    
    func getQuestions() {
        cancellationToken = StackOverflowAPI.request(.questions)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.questions = $0.items
            })
    }
}

