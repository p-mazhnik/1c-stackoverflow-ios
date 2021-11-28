//
//  QuestionView.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 25.11.2021.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    @ObservedObject var viewModel: AnswerListViewModel

    init(question: Question) {
        self.question = question
        viewModel = AnswerListViewModel(questionId: question.questionId)
    }
    
    var body: some View {
        GeometryReader { g in
            ScrollView {
                VStack {
                    Text(question.title)
                            .font(.headline)
                    // HTMLStringView(htmlContent: question.body)
                    Text("Score: \(question.score)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(6)
                    Text("Author: \(question.owner.displayName)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(6)
                    ForEach(viewModel.answers) {
                        answer in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Score: \(answer.score)")
                                        .font(.subheadline)
                            }
                        }.padding(.horizontal, 8)
                    }
                }
            }
        }
    }
}

