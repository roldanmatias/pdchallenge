//
//  LoggerProtocol.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

protocol LoggerProtocol {
    
    func error(_ error: Error)
    func event(_ event: String)
}
