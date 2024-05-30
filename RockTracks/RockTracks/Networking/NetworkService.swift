//
//  NetworkService.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation

class NetworkService: ObservableObject {
    @Published var tracks = [Track]()
    
    func fetchTracks() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=rock&entity=song") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        self.tracks = searchResult.results
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
