//
//  Entry.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import Foundation

class Entry: Codable {
    var title: String
    var body: String
    var timestamp: Date
    let uuid: String
    
    init(title: String, body: String, timestamp: Date = Date(), uuid: String = UUID().uuidString) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.uuid = uuid
        print("timestamp: \(timestamp)")
    }
}

// MARK:- Extensions
extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
