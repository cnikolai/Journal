//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Cynthia Nikolai on 4/19/21.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK:- Properties
    var entry: Entry?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK:- Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let entry = entry {
            print("to be implemented tomorrow")
        } else {
            guard let title = titleTextField.text, !title.isEmpty,
                  let body = bodyTextView.text, !body.isEmpty else { return }
            
            EntryController.sharedInstance.createEntryWith(title: title, body: body, timestamp: Date(), uuid: UUID().uuidString)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearFieldsButton(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    // MARK:- Functions
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
}
