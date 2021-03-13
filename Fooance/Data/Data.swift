//
//  Data.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI

struct ItemsList: Identifiable, Hashable, Codable {
    var id = UUID()
    var items: [Item]
    var date: Date
}
struct Item: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var price: String
    var expirationDate: Date
    var check: Bool
    var noti: Bool
    var notiSet: Bool
}





