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
        saveToPersistenceStore()
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK:- Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Journal.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: createPersistenceStore())
        } catch {
            //print("Error encoding songs")
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    
}
