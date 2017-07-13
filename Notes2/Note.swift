//
//  Note.swift
//  Notes2
//
//  Created by Nate Dukatz on 7/12/17.
//  Copyright © 2017 NateDukatz. All rights reserved.
//

import Foundation

class Note: Equatable {
    var text: String
    
    private static let textKey = "text"
    
    init(text: String){
        self.text = text
    }
    
    // MARK: - Dictionary Conversions
    
    convenience init?(dictionary: [String : Any]) {
        guard let text = dictionary[Note.textKey] as? String else { return nil }
        
        self.init(text: text)
    }
    
    var dictionaryRepresentation: [String : Any] {
        var dictionary = [String : Any]()
        
        dictionary[Note.textKey] = self.text
        
        return dictionary
    }
    
}

func ==(lhs: Note, rhs: Note) -> Bool {
    return lhs.text == rhs.text
}
