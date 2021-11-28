//
//  ContentView.swift
//  Shared
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import SwiftUI

struct SOListView: View {

    @ObservedObject var viewModel = SOListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.questions) {
                question in
                HStack {
                    NavigationLink(destination: QuestionView(question: question)) {
                            VStack(alignment: .leading) {
                                Text(question.title)
                                    .font(.headline)
                                Text("Score: \(question.score)")
                                    .font(.subheadline)
                                Text("Author: \(question.owner.displayName)")
                                    .font(.subheadline)
                            }
                        }
                }
            }
        }
        .navigationTitle("iOS Stackoverflow")
    }
}

struct SOListView_Previews: PreviewProvider {
    static var previews: some View {
        SOListView()
    }
}
