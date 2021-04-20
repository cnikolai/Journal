//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK:- Properties
    var entry: Entry?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //EntryController.sharedInstance.createEntryWith(title: "Test Title", body: "Test Body", timestamp: Date(), uuid: UUID().uuidString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.sharedInstance.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        return cell
    }
  
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.sharedInstance.entries[indexPath.row]
            EntryController.sharedInstance.delete(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDO
        let entry = self.entry
        guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
        destinationVC.entry = entry

        if segue.identifier == "toJournalDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let entry = EntryController.sharedInstance.entries[indexPath.row]
        
            destinationVC.entry = entry
        }
    }
    
}
