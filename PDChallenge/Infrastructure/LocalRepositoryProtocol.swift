//
//  LocalRepositoryProtocol.swift
//  PDChallenge
//
//  Created by Matias Roldan on 09/09/2023.
//

import Foundation

protocol LocalRepositoryProtocol {
    
    var charactersDetail: [CharacterDetail] { get }
    
    func add(_ characterDetail: CharacterDetail)
    func remove(_ characterDetail: CharacterDetail)
}
