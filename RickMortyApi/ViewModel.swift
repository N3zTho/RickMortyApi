//
//  ViewModel.swift
//  RickMortyApi
//
//  Created by Ernesto Redonet on 2/1/23.
//

import Foundation

struct CharacterModel : Decodable {
    let id: Int
    let name:String
    let image:String
    let episode: [String]
    let locationName: String
    let locationURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case episode
        case location
        case locationURL = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CharacterModel.CodingKeys> = try decoder.container(keyedBy: CharacterModel.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: CharacterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CharacterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: CharacterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: CharacterModel.CodingKeys.episode)
        
        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
        self.locationURL = try locationContainer.decode(String.self, forKey: .locationURL)
        
    }
}

struct EpisodeModel : Codable {
    let id: Int
    let name: String
}

final class ViewModel {
    func executeRequest() {
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        
        URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
            print("Character Model \(characterModel)")
            
            let firstEpisode = URL(string:  characterModel.episode.first!)!
            URLSession.shared.dataTask(with: firstEpisode) { data, response, error in
                let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
                print("Episode Model \(episodeModel)")
                
            }.resume()
            
        }.resume()
    }
}
