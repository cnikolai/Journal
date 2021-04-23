//
//  EntryController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import Foundation

class EntryController {
        
    // MARK:- CRUD
    // Create
    static func createEntryWith(journal: Journal, title: String, body: String,timestamp: Date, uuid:String) {
        let newEntry = Entry(title: title, body: body, timestamp: timestamp, uuid: uuid)
        JournalController.sharedInstance.addEntryToJournal(journal: journal, entry: newEntry)
        //saveToPersistenceStore()
    }
    
    // Delete
    static func deleteEntry(journal: Journal, entry: Entry) {
        JournalController.sharedInstance.removeEntryFromJournal(journal: journal, entry: entry)
        //saveToPersistenceStore()
    }
    
    // Update
    static func updateEntry(journal: Journal, entry: Entry) {
        JournalController.sharedInstance.updateEntryFromJournal(journal: journal, entry: entry)
        //saveToPersistenceStore()
    }
    
}
