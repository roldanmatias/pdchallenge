//
//  MockAPIRepository.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 11/09/2023.
//

import Foundation
@testable import PDChallenge

final class MockAPIRepository: APIRepositoryProtocol {

    var getLocationDetailWasCalled = false
    var loadMoreCharactersWasCalled = false
    var searchWasCalled = false
  
    func getLocationDetail(
        location: Location, 
        onSuccess: @escaping LocationDetailClosure, 
        onError: @escaping ErrorClosure
    ) {
        getLocationDetailWasCalled = true
    }
    
    func loadMoreCharacters(
        info: Info, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        loadMoreCharactersWasCalled = true
    }
    
    func search(
        filter: SearchFilter, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        searchWasCalled = true
    }
}
