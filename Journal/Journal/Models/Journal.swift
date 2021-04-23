//
//  Journal.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/20/21.
//

import Foundation

class Journal: Codable {
    var title: String
    var entries: [Entry]
    let uuid: String
    
    init(title: String, entries: [Entry] = [], uuid: String = UUID().uuidString) {
        self.title = title
        self.entries = entries
        self.uuid = uuid
    }
}

// MARK:- Extensions
extension Journal: Equatable {
    static func ==(lhs: Journal, rhs: Journal) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
