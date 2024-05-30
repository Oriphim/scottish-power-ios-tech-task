//
//  TrackViewModelTests.swift
//  TrackViewModelTests
//
//  Created by Henry Tsang on 30/05/2024.
//

import XCTest
@testable import RockTracks

class TrackViewModelTests: XCTestCase {
    
    var viewModel: TrackViewModel!
    
    override func setUpWithError() throws {
        viewModel = TrackViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchTracks() throws {
        let expectation = self.expectation(description: "Fetching tracks")
        
        viewModel.fetchTracks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertFalse(viewModel.tracks.isEmpty, "Tracks should not be empty")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }
    
    func testSortTracksByReleaseDate() throws {
        let track1 = Track(trackId: 1, trackName: "Track 1", artistName: "Artist 1", trackPrice: 1.99, artworkUrl100: nil, trackTimeMillis: 300000, releaseDate: "2022-01-01T00:00:00Z", trackViewUrl: nil)
        let track2 = Track(trackId: 2, trackName: "Track 2", artistName: "Artist 2", trackPrice: 1.99, artworkUrl100: nil, trackTimeMillis: 300000, releaseDate: "2023-01-01T00:00:00Z", trackViewUrl: nil)
        let track3 = Track(trackId: 3, trackName: "Track 3", artistName: "Artist 3", trackPrice: 1.99, artworkUrl100: nil, trackTimeMillis: 300000, releaseDate: "2021-01-01T00:00:00Z", trackViewUrl: nil)
        
        let sortedTracks = viewModel.sortTracksByReleaseDate([track1, track2, track3])
        
        XCTAssertEqual(sortedTracks.first?.trackId, track2.trackId, "The first track should be the one with the latest release date")
        XCTAssertEqual(sortedTracks.last?.trackId, track3.trackId, "The last track should be the one with the earliest release date")
    }
}

extension TrackViewModel {
    func formatReleaseDate(_ releaseDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: releaseDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return releaseDate
    }
}
