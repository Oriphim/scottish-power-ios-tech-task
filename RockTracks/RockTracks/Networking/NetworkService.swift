//
//  NetworkService.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation
import Combine

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchRockTracks() -> AnyPublisher<[Track], Error> {
        let url = URL(string: "https://itunes.apple.com/search?term=rock")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ITunesResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct ITunesResponse: Codable {
    let results: [Track]
}
