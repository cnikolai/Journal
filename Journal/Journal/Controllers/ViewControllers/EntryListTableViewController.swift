//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK:- Properties
    var journal: Journal? 
    var entry: Entry?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let journal = self.journal else { return 0 }
        return journal.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
            
        guard let journal = self.journal else { return UITableViewCell() }
        let entry = journal.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            EntryController.deleteEntry(journal: journal, entry: entryToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDO
        guard let journal = self.journal else { return }
        guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
        destinationVC.journal = journal

        if segue.identifier == "toJournalDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let entry = journal.entries[indexPath.row]
            destinationVC.entry = entry
        }
    }
    
}
