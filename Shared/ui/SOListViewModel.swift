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
                self.questions = self.getQuestionsDB()
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    self.questions = value.items
                    self.saveQuestionsDB()
            })
    }
    
    func getQuestionsDB() -> [Question] {
        return CoreDataManager.shared.getQuestions().map{ questionMO in
            print(questionMO)
            return Question(managedObject: questionMO)
        }
    }
    
    func saveQuestionsDB() {
        self.questions.forEach{
            question in
            let questionMO = QuestionMO(context: CoreDataManager.shared.viewContext)
            questionMO.title = question.title
            questionMO.id = String(question.id)
        }
        CoreDataManager.shared.save()
    }
}

