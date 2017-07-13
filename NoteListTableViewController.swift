//
//  NoteListTableViewController.swift
//  Notes2
//
//  Created by Nate Dukatz on 7/12/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return NoteController.shared.notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let note = NoteController.shared.notes[indexPath.row]
        cell.textLabel?.text = note.text
        
        return cell
    }
    
    
    // MARK: - Editing Rows
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = NoteController.shared.notes[indexPath.row]
            NoteController.shared.delete(note: note)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
 


    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let cell = NoteController.shared.notes[fromIndexPath.row]
        NoteController.shared.notes.remove(at: fromIndexPath.row)
        NoteController.shared.notes.insert(cell, at: to.row)
        
        NoteController.shared.saveToPersistentStorage()
    }
 

    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
 

  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)  else { return }
            let destination = segue.destination as? NoteDetailViewController
            let note = NoteController.shared.notes[indexPath.row]
        
            destination?.note = note
        }
    }
  

}
