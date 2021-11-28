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
        List(viewModel.questions) {
            question in
            HStack {
                VStack(alignment: .leading) {
                    Text(question.title)
                        .font(.headline)
                    Text(String(question.score))
                        .font(.subheadline)
                }
            }
        }
    }
}

struct SOListView_Previews: PreviewProvider {
    static var previews: some View {
        SOListView()
    }
}
