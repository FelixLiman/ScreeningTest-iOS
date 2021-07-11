//
//  EventModel.swift
//  ScreeningTest
//
//  Created by Felix Liman on 11/07/21.
//

import Foundation

struct EventModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let date: String
}
