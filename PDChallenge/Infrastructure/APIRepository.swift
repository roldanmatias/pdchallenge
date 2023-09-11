//
//  Repository.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

final class APIRepository: APIRepositoryProtocol {
    
    private var baseUrl: String
    private var session: URLSessionProtocol
    
    init(baseUrl: String, session: URLSessionProtocol) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    func getLocationDetail(
        location: Location, 
        onSuccess: @escaping LocationDetailClosure, 
        onError: @escaping ErrorClosure
    ) {
        guard let url = URL(string: location.url) else {
            return
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                onError(error)
                return
            }
            
            guard let data else { 
                onError(Constant.noDataError) 
                return
            }
            
            do {
                let locationDetail = try JSONDecoder().decode(LocationDetail.self, from: data)
                onSuccess(locationDetail)
            } catch {
                onError(Constant.noDataError)
            }
        }.resume()
    }
    
    func loadMoreCharacters(
        info: Info, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        guard let nextUrl = info.next else {
            onSuccess(nil)
            return
        }
        
        getCharacters(
            characterUrl: nextUrl, 
            onSuccess: onSuccess, 
            onError: onError
        )
    }
    
    func search(
        filter: SearchFilter, 
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        let query = getQuery(from: filter)
        
        getCharacters(
            characterUrl: baseUrl + Constant.searchPath + query, 
            onSuccess: onSuccess, 
            onError: onError
        )
    }
}

private extension APIRepository {
    
    private enum Constant {
        static let noDataError = NSError(domain: "PDChallenge", code: 404)
        static let searchPath = "/character/?" 
    }
    
    func getQuery(from filter: SearchFilter) -> String {
        var query = "page=\(filter.page)"
        
        if let name = filter.name {
            query += "&name=\(name)"
        }
        
        if let gender = filter.gender {
            query += "&gender=\(gender.rawValue)"
        }
        
        if let species = filter.species {
            query += "&species=\(species)"
        }
        
        if let status = filter.status {
            query += "&status=\(status)"
        }
        
        if let type = filter.type {
            query += "&type=\(type)"
        }

        return query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func getCharacters(
        characterUrl: String,
        onSuccess: @escaping OptionalSearchResultClosure, 
        onError: @escaping ErrorClosure
    ) {
        guard let url = URL(string: characterUrl) else {
            fatalError("Bad characterUrl url: \(characterUrl)")
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                onError(error)
                return
            }
            
            guard let data else { 
                onError(Constant.noDataError) 
                return
            }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                onSuccess(searchResult)
            } catch {
                onError(Constant.noDataError)
            }
        }.resume()  
    }
}
