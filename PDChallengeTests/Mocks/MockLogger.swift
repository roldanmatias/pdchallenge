//
//  MockLogger.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 11/09/2023.
//

import Foundation
@testable import PDChallenge

final class MockLogger: LoggerProtocol {
    
    var errorWasCalled = false
    var eventWasCalled = false
    
    func error(_ error: Error) {
        errorWasCalled = true
    }
    
    func event(_ event: String) {
        eventWasCalled = true
    }
}
