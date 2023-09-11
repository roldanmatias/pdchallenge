//
//  CharacterInfo.swift
//  PDChallenge
//
//  Created by Matias Roldan on 06/09/2023.
//

import Foundation

struct CharacterDetail: Codable {
    var gender: Gender
    var id: Int
    var image: String
    var location: Location
    var name: String
    var origin: Location
    var species: String
    var status: Status
    var type: String
}
