//
//  RepositoryProtocol.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

protocol APIRepositoryProtocol {

    func getLocationDetail(
        location: Location, 
        onSuccess: @escaping LocationDetailClosure, 
        onError: @escaping ErrorClosure
    )
    
    func loadMoreCharacters(
        info: Info, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    )
    
    func search(
        filter: SearchFilter, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    )
}
