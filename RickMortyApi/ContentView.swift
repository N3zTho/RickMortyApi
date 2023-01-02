//
//  ContentView.swift
//  RickMortyApi
//
//  Created by Ernesto Redonet on 2/1/23.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel  = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello Ernesto")
        }
        .padding()
        .onAppear{
            viewModel.executeRequest()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
