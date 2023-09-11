//
//  Logger.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

final class Logger: LoggerProtocol {
    
    func error(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func event(_ event: String) {
        print(event)
    }
}
