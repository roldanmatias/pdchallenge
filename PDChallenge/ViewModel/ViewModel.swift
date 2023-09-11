//
//  ViewModel.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

final class ViewModel: ViewModelProtocol {
    
    private var localRepository: LocalRepositoryProtocol
    private var logger: LoggerProtocol
    private var repository: APIRepositoryProtocol
    
    init(
        repository: APIRepositoryProtocol, 
        localRepository: LocalRepositoryProtocol,
        logger: LoggerProtocol
    ) {
        self.repository = repository
        self.localRepository = localRepository
        self.logger = logger
    }
    
    func getLocationDetail(
        characterDetail: CharacterDetail, 
        onSuccess: @escaping LocationDetailClosure, 
        onError: @escaping ErrorClosure
    ) {
        logger.event("getLocationDetail")
        
        repository.getLocationDetail(
            location: characterDetail.location, 
            onSuccess: { [weak self] locationDetail in
                self?.logger.event("getLocationDetail onSuccess")
                onSuccess(locationDetail)
            }, 
            onError: { [weak self] error in
                self?.logger.error(error)
                onError(error)
            }
        )
    }
    
    func loadMoreCharacters(
        searchResul: SearchResult, 
        onSuccess: @escaping OptionalSearchResultClosure,
        onError: @escaping ErrorClosure
    ) {
        logger.event("loadMoreCharacters")
        
        repository.loadMoreCharacters(
            info: searchResul.info, 
            onSuccess: { [weak self] searchResult in
                self?.logger.event("loadMoreCharacters onSuccess")
                onSuccess(searchResult)
            }, 
            onError: { [weak self] error in
                self?.logger.error(error)
                onError(error)
            }
        )
    }
    
    func search(
        filter: SearchFilter, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        logger.event("search")
        
        repository.search(filter: filter)
        {  [weak self] searchResult in
            self?.logger.event("search onSuccess")
            onSuccess(searchResult)
        } onError: { [weak self] error in
            self?.logger.error(error)
            onError(error)
        }
    }
    
    func setFav(characterDetail: CharacterDetail) {
        logger.event("setFav id: \(characterDetail.id)")
        localRepository.add(characterDetail)
    }
    
    func removeFav(characterDetail: CharacterDetail) {
        logger.event("removeFav id: \(characterDetail.id)")
        localRepository.remove(characterDetail)
    }
    
    func isFav(characterDetail: CharacterDetail) -> Bool {
        localRepository.charactersDetail.contains{ $0.id == characterDetail.id }
    }
}
