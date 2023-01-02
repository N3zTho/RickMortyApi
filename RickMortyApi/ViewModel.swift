//
//  ViewModel.swift
//  RickMortyApi
//
//  Created by Ernesto Redonet on 2/1/23.
//

import Foundation



final class ViewModel : ObservableObject {
    @Published var characterBasicInfo : CharacterBasicInfo = .empty
    var url : String
    
    init(url: String) {
        self.url = url
    }
    
    func executeRequest() async {
        //MARK: Async/Await
        
        let characterURL = URL(string: self.url)!        
        let (data,_) = try! await URLSession.shared.data(from: characterURL)
        let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data)
        
        let firstEpisode = URL(string:  characterModel.episode.first!)
        let (dataFirstEpisode, _) = try! await URLSession.shared.data(from: firstEpisode!)
        let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: dataFirstEpisode)
        
        let (dataLocation, _) = try! await URLSession.shared.data(from: URL(string: characterModel.locationURL)!)
        let locationModel = try! JSONDecoder().decode(LocationModel.self, from: dataLocation)
        
        DispatchQueue.main.async {
            self.characterBasicInfo = .init(name: characterModel.name,
                                            image: URL(string: characterModel.image)!,
                                            firstEpisodeTitle: episodeModel.name,
                                            dimension: locationModel.dimension)
        }
        
              
        //MARK: Pyramid of Doom 👇
        
        /*URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
            print("Character Model \(characterModel)")
            
            let firstEpisode = URL(string:  characterModel.episode.first!)!
            URLSession.shared.dataTask(with: firstEpisode) { data, response, error in
                let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
                print("Episode Model \(episodeModel)")
                
                let characterLocationModel = URL(string: characterModel.locationURL)!
                URLSession.shared.dataTask(with: characterLocationModel) { data, response, error in
                    let locationModel = try! JSONDecoder().decode(LocationModel.self, from: data!)
                    print("Location Model \(locationModel)")
                    
                    DispatchQueue.main.async {
                        self.characterBasicInfo = .init(name: characterModel.name,
                                                        image: URL(string: characterModel.image)!,
                                                        firstEpisodeTitle: episodeModel.name,
                                                        dimension: locationModel.dimension)
                    }
                    
                }.resume()
                
            }.resume()
            
        }.resume()*/
    }
}
