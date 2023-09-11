//
//  MockUserDefaults.swift
//  PDChallengeTests
//
//  Created by Matias Roldan on 11/09/2023.
//

import Foundation

final class MockUserDefaults: UserDefaults {

    var setMethodWasCalled = false
  
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        setMethodWasCalled = true
    }
}
