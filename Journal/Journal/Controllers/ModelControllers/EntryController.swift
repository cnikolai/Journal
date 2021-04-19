//
//  EntryController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import Foundation

class EntryController {
    static var sharedInstance = EntryController()
    
    var entries: [Entry] = []
    
    func createEntryWith(title: String, body: String,timestamp: Date, uuid:String) {
        let newEntry = Entry(title: title, body: body, timestamp: timestamp, uuid: uuid)
        entries.append(newEntry)
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
    }
    
    
    
}
