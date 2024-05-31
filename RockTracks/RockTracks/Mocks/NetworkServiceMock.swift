//
//  NetworkServiceMock.swift
//  RockTracks
//
//  Created by Henry Tsang on 31/05/2024.
//

import Foundation

class NetworkServiceMock: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockTracks: [Track] = []

    init(mockTracks: [Track] = []) {
        self.mockTracks = mockTracks
    }

    func fetchTracks() async throws -> [Track] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockTracks
    }
}
