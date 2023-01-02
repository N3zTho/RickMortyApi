//
//  ContentView.swift
//  RickMortyApi
//
//  Created by Ernesto Redonet on 2/1/23.
//

import SwiftUI

struct ContentView: View {
    
  @StateObject var viewModel  = ViewModel(url: "https://rickandmortyapi.com/api/character/1")
    
    var body: some View {
        VStack {
            
            VStack {
                AsyncImage(url: viewModel.characterBasicInfo.image)
                Text("Name: \(viewModel.characterBasicInfo.name)")
                Text("First Episode: \(viewModel.characterBasicInfo.firstEpisodeTitle)")
                Text("Dimension: \(viewModel.characterBasicInfo.dimension)")
            }
            .padding(.top,20)
        }
        .padding()
        .onAppear{
            Task {
                await viewModel.executeRequest()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
