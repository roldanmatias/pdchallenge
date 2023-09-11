//
//  LocalRepository.swift
//  PDChallenge
//
//  Created by Matias Roldan on 09/09/2023.
//

import Foundation

final class LocalRepository: LocalRepositoryProtocol {
    
    private(set) var charactersDetail: [CharacterDetail]
    
    private var userDefaultsKey: String
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults, userDefaultsKey: String) {
        self.userDefaults = userDefaults
        self.userDefaultsKey = userDefaultsKey
        
        if let data = userDefaults.data(forKey: userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode([CharacterDetail].self, from: data) {
                charactersDetail = decoded
                return
            }
        }

        charactersDetail = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(charactersDetail) {
            userDefaults.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func add(_ characterDetail: CharacterDetail) {
        charactersDetail.append(characterDetail)
        save()
    }
    
    func remove(_ characterDetail: CharacterDetail) {
        charactersDetail.removeAll { $0.id == characterDetail.id }
        save()
    }
}
