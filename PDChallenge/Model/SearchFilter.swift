//
//  SearchFilter.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

struct SearchFilter: Codable {
    var gender: Gender?
    var name: String?
    var page: Int
    var species: String?
    var status: Status?
    var type: String?
}
