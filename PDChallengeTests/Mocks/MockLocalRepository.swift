//
//  MockLocalRepository.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 11/09/2023.
//

import Foundation
@testable import PDChallenge

final class MockLocalRepository: LocalRepositoryProtocol {
    
    var charactersDetail: [CharacterDetail] = []
    var addWasCalled = false
    var removeWasCalled = false
    
    func add(_ characterDetail: CharacterDetail) {
        addWasCalled = true
    }
    
    func remove(_ characterDetail: CharacterDetail) {
        removeWasCalled = true
    }
}
