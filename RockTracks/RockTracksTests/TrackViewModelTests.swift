//
//  TrackViewModelTests.swift
//  TrackViewModelTests
//
//  Created by Henry Tsang on 30/05/2024.
//

import XCTest
@testable import RockTracks

class TrackViewModelTests: XCTestCase {

    var mockService: NetworkServiceMock!
    var mockTracks: [Track]!

    override func setUpWithError() throws {
        mockTracks = [
            Track(trackId: 1, trackName: "Test Track 1", artistName: "Test Artist 1", trackPrice: 1.99, artworkUrl100: nil, trackTimeMillis: 133337, releaseDate: "2023-01-01T00:00:00Z", trackViewUrl: nil),
            Track(trackId: 2, trackName: "Test Track 2", artistName: "Test Artist 2", trackPrice: 2.99, artworkUrl100: nil, trackTimeMillis: 123456, releaseDate: "2022-01-01T00:00:00Z", trackViewUrl: nil)
        ]
        mockService = NetworkServiceMock(mockTracks: mockTracks)
    }

    override func tearDownWithError() throws {
        mockService = nil
        mockTracks = nil
    }

    func testFetchTracksSuccess() async throws {
        let viewModel = await createViewModel()
        mockService.shouldReturnError = false

        await viewModel.fetchTracks()

        await MainActor.run {
            XCTAssertFalse(viewModel.tracks.isEmpty, "Tracks should not be empty")
            XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
            XCTAssertEqual(viewModel.tracks.count, mockTracks.count, "There should be \(mockTracks.count) tracks")
        }
    }

    func testFetchTracksFailure() async throws {
        let viewModel = await createViewModel()
        mockService.shouldReturnError = true

        await viewModel.fetchTracks()

        await MainActor.run {
            XCTAssertTrue(viewModel.tracks.isEmpty, "Tracks should be empty")
            XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil")
        }
    }

    func testSortTracksByReleaseDate() async throws {
        let viewModel = await createViewModel()
        let unsortedTracks = [
            Track(trackId: 1, trackName: "Test Track 1", artistName: "Test Artist 1", trackPrice: 1.99, artworkUrl100: nil, trackTimeMillis: 133337, releaseDate: "2022-01-01T00:00:00Z", trackViewUrl: nil),
            Track(trackId: 2, trackName: "Test Track 2", artistName: "Test Artist 2", trackPrice: 2.99, artworkUrl100: nil, trackTimeMillis: 123456, releaseDate: "2023-01-01T00:00:00Z", trackViewUrl: nil),
            Track(trackId: 3, trackName: "Test Track 3", artistName: "Test Artist 3", trackPrice: 3.99, artworkUrl100: nil, trackTimeMillis: 300000, releaseDate: "2021-01-01T00:00:00Z", trackViewUrl: nil)
        ]

        let sortedTracks = await viewModel.sortTracksByReleaseDate(unsortedTracks)

        XCTAssertEqual(sortedTracks.first?.trackId, unsortedTracks[1].trackId, "The first track should be the one with the latest release date")
        XCTAssertEqual(sortedTracks.last?.trackId, unsortedTracks[2].trackId, "The last track should be the one with the earliest release date")
    }

    // Helper function to create the view model
    private func createViewModel() async -> TrackViewModel {
        await MainActor.run {
            return TrackViewModel(networkService: mockService)
        }
    }
}
