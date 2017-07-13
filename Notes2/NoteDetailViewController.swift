//
//  NoteDetailViewController.swift
//  Notes2
//
//  Created by Nate Dukatz on 7/12/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        if let note = note {
            NoteController.shared.update(note: note, text: textView.text)
        } else {
            NoteController.shared.create(text: textView.text)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = note {
            updateView(note: note)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(note: Note) {
        textView.text = note.text
    }


}
