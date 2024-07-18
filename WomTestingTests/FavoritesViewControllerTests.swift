//
//  FavoritesViewControllerTests.swift
//  WomTestingTests
//
//  Created by Jose David Bustos H on 17-07-24.
//
import XCTest
@testable import WomTesting

class FavoritesViewControllerTests: XCTestCase {

    var sut: FavoritesViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FavoritesViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        UserDefaults.standard.removeObject(forKey: "favoriteTracks")
        try super.tearDownWithError()
    }

    func testLoadFavorites_withEmptyFavorites() {
        // Given
        UserDefaults.standard.set(nil, forKey: "favoriteTracks")
        
        // When
        sut.loadFavorites()
        
        // Then
        XCTAssertEqual(sut.favorites.count, 0)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func testLoadFavorites_withSomeFavorites() {
        // Given
        let track1 = Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        let track2 =  Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        let favoritesData = [track1, track2].compactMap { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(favoritesData, forKey: "favoriteTracks")
        
        // When
        sut.loadFavorites()
        
        // Then
        XCTAssertEqual(sut.favorites.count, 2)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }

    func testFavoriteAddedNotification() {
        // Given
        let track =  Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        let favoritesData = [track].compactMap { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(favoritesData, forKey: "favoriteTracks")
        
        // When
        NotificationCenter.default.post(name: NSNotification.Name("FavoriteAdded"), object: nil)
        
        // Then
        XCTAssertEqual(sut.favorites.count, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableViewCellConfiguration() {
        // Given
        let track = Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        let favoritesData = [track].compactMap { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(favoritesData, forKey: "favoriteTracks")
        sut.loadFavorites()
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FavoritesTableViewCell
        
        // Then
//        XCTAssertEqual(cell.textLabel?.text, "Track 1")
//        XCTAssertEqual(cell.detailTextLabel?.text, "Artist 1 - Collection 1")
    }
}
