//
//  JournalController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/20/21.
//

import Foundation

class JournalController {
    
    static let sharedInstance = JournalController()
    
    // MARK:- Properties
    var journals: [Journal] = []
    
    // MARK:- CRUD - Journal
    // Create
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistenceStore()
    }
    
    // Delete
    func deleteJournal(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistenceStore()
    }
    
    // Create Entry for Journal
    func addEntryToJournal(journal: Journal, entry: Entry) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals[index].entries.append(entry)
        saveToPersistenceStore()
    }
    
    // Delete Entry from Journal
    func removeEntryFromJournal(journal: Journal, entry: Entry) {
        guard let journalIndex = journals.firstIndex(of: journal),
              let entryIndex = journals[journalIndex].entries.firstIndex(of: entry) else { return }
        journals[journalIndex].entries.remove(at: entryIndex)
        saveToPersistenceStore()
    }
    
    // Update Entry from Journal
    func updateEntryFromJournal(journal: Journal, entry: Entry) {
        guard let journalIndex = journals.firstIndex(of: journal),
              let entryIndex = journals[journalIndex].entries.firstIndex(of: entry) else { return }
        journals[journalIndex].entries[entryIndex].title = entry.title
        journals[journalIndex].entries[entryIndex].body = entry.body
        journals[journalIndex].entries[entryIndex].timestamp = entry.timestamp
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
            let data = try JSONEncoder().encode(journals)
            try data.write(to: createPersistenceStore())
        } catch {
            //print("Error encoding songs")
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}
