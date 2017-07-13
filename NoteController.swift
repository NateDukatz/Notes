//
//  NoteController.swift
//  Notes2
//
//  Created by Nate Dukatz on 7/12/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import Foundation

class NoteController {
    
    static let shared = NoteController()
    private static let notesKey = "notes"
    
    init() {
        loadPersistentStorage()
    }
    
    // MARK: - CRUD Stuff
    var notes = [Note]()
    
    func create(text: String) {
        let note = Note(text: text)
        
        notes.append(note)
        
        saveToPersistentStorage()
    }
    
    func update(note: Note, text: String) {
       
        note.text = text
        
        saveToPersistentStorage()
    }
    
    func delete(note: Note) {
        guard let index = notes.index(of: note) else { return }
        
        notes.remove(at: index)
        
        saveToPersistentStorage()
    }
    
    // MARK: - Data Persistence
    
    func saveToPersistentStorage() {
        let noteDictionaries = notes.map({$0.dictionaryRepresentation})
        
        UserDefaults.standard.set(noteDictionaries, forKey: NoteController.notesKey)
        UserDefaults.standard.synchronize()
    }
    
    func loadPersistentStorage() {
        guard let notesDictionaries = UserDefaults.standard.array(forKey: NoteController.notesKey) as? [[String : Any]] else { return }
        
        notes = notesDictionaries.flatMap({ Note(dictionary: $0) })
    }
}
