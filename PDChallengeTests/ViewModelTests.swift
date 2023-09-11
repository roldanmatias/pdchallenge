//
//  ViewModelTests.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 10/09/2023.
//

import XCTest
@testable import PDChallenge

final class ViewModelTests: XCTestCase {

    func testViewModelGetLocationDetail_success() {
        // given 
        let mockAPIRepository = MockAPIRepository()
        let localRepository = MockLocalRepository()
        let logger = MockLogger()
        
        let viewModel = ViewModel(
            repository: mockAPIRepository, 
            localRepository: localRepository, 
            logger: logger
        )
        let characterDetail = CharacterDetail(
            gender: .male, 
            id: 1, 
            image: "", 
            location: Location(name: "", url: ""), 
            name: "", 
            origin: Location(name: "", url: ""), 
            species: "", 
            status: .alive, 
            type: ""
        )
        
        // when
        viewModel.getLocationDetail(
            characterDetail: characterDetail, 
            onSuccess: { _ in
            }, 
            onError: { _ in
            }
        )
        
        // then
        XCTAssertTrue(mockAPIRepository.getLocationDetailWasCalled)
        XCTAssertTrue(logger.eventWasCalled)
    }
    
    func testViewModelLoadMoreCharacters_success() {
        // given 
        let mockAPIRepository = MockAPIRepository()
        let localRepository = MockLocalRepository()
        let logger = MockLogger()
        
        let viewModel = ViewModel(
            repository: mockAPIRepository, 
            localRepository: localRepository, 
            logger: logger
        )
        let searchResult = SearchResult(info: Info(count: 0, pages: 0))
        
        // when
        viewModel.loadMoreCharacters(
            searchResul: searchResult, 
            onSuccess: { _ in
            }, 
            onError: { _ in
            }
        )
        
        // then
        XCTAssertTrue(mockAPIRepository.loadMoreCharactersWasCalled)
        XCTAssertTrue(logger.eventWasCalled)
    }
    
    func testViewModelSearch_success() {
        // given 
        let mockAPIRepository = MockAPIRepository()
        let localRepository = MockLocalRepository()
        let logger = MockLogger()
        
        let viewModel = ViewModel(
            repository: mockAPIRepository, 
            localRepository: localRepository, 
            logger: logger
        )
        let filter = SearchFilter(page: 0)
        
        // when
        viewModel.search(
            filter: filter, 
            onSuccess: { _ in
            }, 
            onError: { _ in
            }
        )
        
        // then
        XCTAssertTrue(mockAPIRepository.searchWasCalled)
        XCTAssertTrue(logger.eventWasCalled)
    }
    
    func testViewModelSetFav_success() {
        // given 
        let mockAPIRepository = MockAPIRepository()
        let mockLocalRepository = MockLocalRepository()
        let logger = MockLogger()
        
        let viewModel = ViewModel(
            repository: mockAPIRepository, 
            localRepository: mockLocalRepository, 
            logger: logger
        )
        let characterDetail = CharacterDetail(
            gender: .male, 
            id: 1, 
            image: "", 
            location: Location(name: "", url: ""), 
            name: "", 
            origin: Location(name: "", url: ""), 
            species: "", 
            status: .alive, 
            type: ""
        )
        
        
        // when
        viewModel.setFav(characterDetail: characterDetail)
        
        // then
        XCTAssertTrue(mockLocalRepository.addWasCalled)
        XCTAssertTrue(logger.eventWasCalled)
    }
    
    func testViewModelRemoveFav_success() {
        // given 
        let mockAPIRepository = MockAPIRepository()
        let mockLocalRepository = MockLocalRepository()
        let logger = MockLogger()
        
        let viewModel = ViewModel(
            repository: mockAPIRepository, 
            localRepository: mockLocalRepository, 
            logger: logger
        )
        let characterDetail = CharacterDetail(
            gender: .male, 
            id: 1, 
            image: "", 
            location: Location(name: "", url: ""), 
            name: "", 
            origin: Location(name: "", url: ""), 
            species: "", 
            status: .alive, 
            type: ""
        )
        
        
        // when
        viewModel.removeFav(characterDetail: characterDetail)
        
        // then
        XCTAssertTrue(mockLocalRepository.removeWasCalled)
        XCTAssertTrue(logger.eventWasCalled)
    }
}
