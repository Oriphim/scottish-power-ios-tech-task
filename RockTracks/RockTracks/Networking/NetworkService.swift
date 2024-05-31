//
//  NetworkService.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation

class NetworkService {
    func fetchTracks() async throws -> [Track] {
        let url = URL(string: "https://itunes.apple.com/search?term=rock&entity=song")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let searchResult = try decoder.decode(SearchResult.self, from: data)
        return searchResult.results
    }
}
