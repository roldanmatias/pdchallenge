//
//  APIRepositoryTests.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 10/09/2023.
//

import XCTest
@testable import PDChallenge

final class APIRepositoryTests: XCTestCase {

    var apiRepository: APIRepository!
    var mockSession: MockURLSession!

    override func tearDown() {
        apiRepository = nil
        mockSession = nil
        super.tearDown()
    }

    func testRepositorygetLocationDetail_successResult() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "Location", 
            andStatusCode: 200, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let location = Location(name: "name", url: "url")
        
        // when
        apiRepository.getLocationDetail(
            location: location, 
            onSuccess: { locationDetail in
                // then
                XCTAssertNotNil(locationDetail)
            }, 
            onError: { _ in
                XCTFail("getLocationDetail resturns 0 results")
            })
    }
    
    func testRepositorygetLocationDetail_onError() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "WrongLocationFile", 
            andStatusCode: 404, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let location = Location(name: "name", url: "url")
        
        // when
        apiRepository.getLocationDetail(
            location: location, 
            onSuccess: { _ in
                // then
                XCTFail("GetLocation should retuns error")
            }, 
            onError: { error in
                XCTAssertNotNil(error)
            })
    }
    
    func testRepositoryLoadMoreCharacters_successResult() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "Characters", 
            andStatusCode: 200, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let info = Info(count: 0, next: "http://google.com", pages: 1)
        
        // when
        apiRepository.loadMoreCharacters(
            info: info, 
            onSuccess: { searchResult in
                // then
                XCTAssertNotNil(searchResult)
                XCTAssertTrue(searchResult?.results?.count ?? 0 > 0)
            }, 
            onError: { _ in
                XCTFail("loadMoreCharacters resturns 0 results")
            }
        )
    }
    
    func testRepositoryLoadMoreCharacters_onError() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "wrongCharactersFile", 
            andStatusCode: 404, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let info = Info(count: 0, next: "http://google.com", pages: 1)
        
        // when
        apiRepository.loadMoreCharacters(
            info: info, 
            onSuccess: { searchResult in
                // then
                XCTFail("loadMoreCharacters should retuns error")
            }, 
            onError: { error in
                XCTAssertNotNil(error)
            }
        )
    }
    
    func testRepositorySeearch_successResult() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "Characters", 
            andStatusCode: 200, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let filter = SearchFilter(page: 0)
        
        // when
        apiRepository.search(
            filter: filter, 
            onSuccess: { searchResult in
                
                // then
                XCTAssertNotNil(searchResult)
                XCTAssertTrue(searchResult?.results?.count ?? 0 > 0)    
            }, 
            onError: { _ in
                XCTFail("Search resturns 0 results")    
            }
        )
    }
    
    func testRepositorySeearch_onError() {
        // given
        mockSession = createMockSession(
            fromJsonFile: "wrongCharactersFile", 
            andStatusCode: 404, 
            andError: nil
        )
        
        apiRepository = APIRepository(baseUrl: "baseUrl", session: mockSession)
        let filter = SearchFilter(page: 0)
        
        // when
        apiRepository.search(
            filter: filter, 
            onSuccess: { _ in
                // then
                XCTFail("Search should retuns error")
            }, 
            onError: { error in
                // then
                XCTAssertNotNil(error)
            }
        )
    }

    private func loadJsonData(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }

    private func createMockSession(
        fromJsonFile file: String,   
        andStatusCode code: Int,
        andError error: Error?) -> MockURLSession? 
    {
        let data = loadJsonData(file: file)
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
