//
//  SearchResult.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

struct SearchResult: Codable {
    var info: Info
    var results: [CharacterDetail]?
}
