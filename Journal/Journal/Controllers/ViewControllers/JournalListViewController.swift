//
//  JournalListViewController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/22/21.
//

import UIKit

class JournalListViewController: UIViewController {

    // MARK:- Properties
    var journal: Journal?
    
    // MARK:- Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        journalListTableView.delegate = self
        journalListTableView.dataSource = self
      
        JournalController.sharedInstance.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        journalListTableView.reloadData()
    }
    
    // MARK:- Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        if let journalTitle = journalTitleTextField.text, !journalTitle.isEmpty {
            JournalController.sharedInstance.createJournalWith(title: journalTitle)
        }
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDO
        let journal = self.journal
        guard let destinationVC = segue.destination as? EntryListTableViewController else { return }
        destinationVC.journal = journal

        if segue.identifier == "toEntryList" {
            guard let indexPath = journalListTableView.indexPathForSelectedRow else { return }
            
            let journal = JournalController.sharedInstance.journals[indexPath.row]
        
            destinationVC.journal = journal
        }
    }
}//end of class


extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        JournalController.sharedInstance.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)

        let journal = JournalController.sharedInstance.journals[indexPath.row]
        let entryCount = journal.entries.count
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(entryCount) Journal Entries"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //guard let journal = journal else { return }
            let journalToDelete = JournalController.sharedInstance.journals[indexPath.row]
            JournalController.sharedInstance.deleteJournal(journal: journalToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
