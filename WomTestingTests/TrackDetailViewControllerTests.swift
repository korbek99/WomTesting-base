//
//  TrackDetailViewControllerTests.swift
//  WomTestingTests
//
//  Created by Jose David Bustos H on 17-07-24.
//
import XCTest
@testable import WomTesting

class TrackDetailViewControllerTests: XCTestCase {
    
    var track: Track!
    var sut: TrackDetailViewController!

    override func setUp() {
        super.setUp()

        track = Track(
            wrapperType: "track",
            kind: "song",
            artistId: 1,
            collectionId: 1,
            trackId: 1,
            artistName: "Test Artist",
            collectionName: "Test Album",
            trackName: "Test Track",
            collectionCensoredName: "Test Album",
            trackCensoredName: "Test Track",
            artistViewUrl: "http://example.com",
            collectionViewUrl: "http://example.com",
            trackViewUrl: "http://example.com",
            previewUrl: "http://example.com",
            artworkUrl30: "http://example.com/image30.jpg",
            artworkUrl60: "http://example.com/image60.jpg",
            artworkUrl100: "http://example.com/image100.jpg",
            collectionPrice: 9.99,
            trackPrice: 0.99,
            releaseDate: "2024-01-01T00:00:00Z",
            collectionExplicitness: "notExplicit",
            trackExplicitness: "notExplicit",
            discCount: 1,
            discNumber: 1,
            trackCount: 10,
            trackNumber: 1,
            trackTimeMillis: 200000,
            country: "USA",
            currency: "USD",
            primaryGenreName: "Pop",
            isStreamable: true
        )
      
        sut = TrackDetailViewController(track: track)
        
        _ = sut.view
    }

    override func tearDown() {
        track = nil
        sut = nil
        super.tearDown()
    }

    func testTrackDetailViewController_Initialization() {
        XCTAssertNotNil(sut, "The view controller should not be nil.")
        XCTAssertEqual(sut.track.artistName, "Test Artist", "The artist name should be set correctly.")
    }

    func testTrackDetailViewController_CollectionView() {
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 3, "There should be 3 items in the collection view.")
    }

    func testTrackDetailViewController_Labels() {
        sut.configure(with: track)
        
        XCTAssertEqual(sut.artistLabel.text, "Artist: Test Artist", "The artist label should display the correct artist name.")
        XCTAssertEqual(sut.albumLabel.text, "Album: Test Album", "The album label should display the correct album name.")
        XCTAssertEqual(sut.trackLabel.text, "Track: Test Track", "The track label should display the correct track name.")
    }
}
