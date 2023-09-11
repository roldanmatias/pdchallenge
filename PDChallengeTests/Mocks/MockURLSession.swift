//
//  MockURLSession.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 10/09/2023.
//

import Foundation
@testable import PDChallenge

class MockURLSession: URLSessionProtocol {

    var dataTask = MockURLSessionDataTask()
    var completionHandler: (Data?, URLResponse?, Error?)

    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }

    func dataTask(
        with request: URLRequest, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.0, self.completionHandler.1, self.completionHandler.2)
        return dataTask
    }
}
