//
//  ViewModelFactory.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

final class ViewModelFactory {
    
    static func createViewModel() -> ViewModelProtocol {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String else {
            fatalError("Base url is not found in info.plist")
        }

        let repository = APIRepository(baseUrl: baseUrl, session: URLSession.shared)
        let localRepository = LocalRepository(
            userDefaults: UserDefaults.standard, 
            userDefaultsKey: "FavCharacters"
        )
        let viewModel = ViewModel(
            repository: repository, 
            localRepository: localRepository, 
            logger: Logger()
        )
        return viewModel
    }
}
