//
//  LocalRepositoryTests.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 10/09/2023.
//

import XCTest
@testable import PDChallenge

final class LocalRepositoryTests: XCTestCase {

    var localRepository: LocalRepository!

    override func tearDown() {
        localRepository = nil
        super.tearDown()
    }

    func testLocalRepositoryAdd_success() {
        // given
        let mockUserDefaults = MockUserDefaults()
        localRepository = LocalRepository(
            userDefaults: mockUserDefaults, 
            userDefaultsKey: "UnitTest"
        )
        let charaterDetail = CharacterDetail(
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
        localRepository.add(charaterDetail)
        
        // then
        XCTAssertTrue(localRepository.charactersDetail.contains { $0.id == charaterDetail.id })
        XCTAssertTrue(mockUserDefaults.setMethodWasCalled)
    }
    
    func testLocalRepositoryRemove_success() {
        // given
        let mockUserDefaults = MockUserDefaults()
        localRepository = LocalRepository(
            userDefaults: mockUserDefaults, 
            userDefaultsKey: "UnitTest"
        )
        let charaterDetail = CharacterDetail(
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
        localRepository.remove(charaterDetail)
        
        // then
        XCTAssertFalse(localRepository.charactersDetail.contains { $0.id == charaterDetail.id })
        XCTAssertTrue(mockUserDefaults.setMethodWasCalled)
    }
}
