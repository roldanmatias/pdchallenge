//
//  ViewModelProtocol.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

protocol ViewModelProtocol {
    
    func getLocationDetail(
        characterDetail: CharacterDetail, 
        onSuccess: @escaping LocationDetailClosure, 
        onError: @escaping ErrorClosure
    )
    
    func isFav(characterDetail: CharacterDetail) -> Bool
    
    func loadMoreCharacters(
        searchResul: SearchResult, 
        onSuccess: @escaping OptionalSearchResultClosure,
        onError: @escaping ErrorClosure
    )
    
    func removeFav(characterDetail: CharacterDetail)
    
    func search(
        filter: SearchFilter, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    )
    
    func setFav(characterDetail: CharacterDetail)
}
