//
//  ViewController.swift
//  JSONParsingProjects
//
//  Created by Remberto  Nunez  on 10/14/19.
//  Copyright © 2019 Remberto  Nunez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var pokemonArray: [Pokemon] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TEST WITH LOCAL JSON
//    inProjectJSONParsing()
    
    // TEST WITH API LINK
    for _ in 1...6 {
      NetworkManager.shared.callAPI(using: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...807))") { data, _ in
        guard let data = data, let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
        self.pokemonArray.append(pokemon)
        print(self.pokemonArray)
      }
    }
  }
  
  func inProjectJSONParsing() {
    guard let pokemonJSONURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json"), let jsonData = try? Data(contentsOf: pokemonJSONURL) else { return }
    let pokemon = try? JSONDecoder().decode(Pokemon.self, from: jsonData)
    print(pokemon)
  }
  
}

struct Pokemon: Codable {
  let name: String
  let abilities: [Ability]
  let baseExperience: Int
  let forms: [NameURL]
  let gameIndices: [GameIndices]
  let height: Int
  let locationArea: String
  let moves: [Moves]
  let order: Int
  let species: NameURL
  let sprites: Sprites
  let stats: [Stats]
  let types: [Types]
  let weight: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case abilities
    case baseExperience = "base_experience"
    case forms
    case gameIndices = "game_indices"
    case height
    case locationArea = "location_area_encounters"
    case moves
    case order
    case species
    case sprites
    case stats
    case types
    case weight
  }
}

struct NameURL: Codable {
  let name: String
  let url: String
}

struct Ability: Codable {
  let ability: NameURL
  let isHidden: Bool
  
  enum CodingKeys: String, CodingKey {
    case ability
    case isHidden = "is_hidden"
  }
}

struct GameIndices: Codable {
  let gameIndex: Int
  let version: NameURL
  
  enum CodingKeys: String, CodingKey {
    case gameIndex = "game_index"
    case version
  }
}

struct VersionGroupDetail: Codable {
  let levelLearned: Int
  let moveLearn: NameURL
  let versionGroup: NameURL
  
  enum CodingKeys: String, CodingKey {
    case levelLearned = "level_learned_at"
    case moveLearn = "move_learn_method"
    case versionGroup = "version_group"
  }
}

struct Moves: Codable {
  let move: NameURL
  let versionGroupDetail: [VersionGroupDetail]
  
  enum CodingKeys: String, CodingKey {
    case move
    case versionGroupDetail = "version_group_details"
  }
}

struct Sprites: Codable {
  let backDefault: String
  let backFemale: String?
  let backShiny: String
  let backShinyFemale: String?
  let frontDefault: String
  let frontFemale: String?
  let frontShiny: String
  let frontShinyFemale: String?
  
  enum CodingKeys: String, CodingKey {
    case backDefault = "back_default"
    case backFemale = "back_female"
    case backShiny = "back_shiny"
    case backShinyFemale = "back_shiny_female"
    case frontDefault = "front_default"
    case frontFemale = "front_female"
    case frontShiny = "front_shiny"
    case frontShinyFemale = "front_shiny_female"
  }
}

struct Stats: Codable {
  let baseStat: Int
  let effort: Int
  let stat: NameURL
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort
    case stat
  }
}

struct Types: Codable {
  let slot: Int
  let type: NameURL
}
