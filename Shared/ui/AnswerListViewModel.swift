//
// Created by Pavel Mazhnik on 25.11.2021.
//

import Foundation
import Combine

class AnswerListViewModel: ObservableObject {
    let questionId: Int

    @Published var answers: [Answer] = []
    var cancellationToken: AnyCancellable?

    init(questionId: Int) {
        self.questionId = questionId
    }

    func getAnswers() {
        cancellationToken = StackOverflowAPI.requestAnswers(questionId: questionId)
                .mapError({ (error) -> Error in
                    print(error)
                    return error
                })
                .sink(receiveCompletion: { _ in },
                        receiveValue: {
                            self.answers = $0.items
                        })
    }
}

