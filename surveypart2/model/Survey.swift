//
//  Survey.swift
//  surveypart2
//
//  Created by Brian Licea on 10/5/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation

struct Survey {
    
    // Mark: - Keys
    private let nameKey = "name"
    private let emojiKey = "emoji"
    private let uuidKey = "uuid"
    
    
    // Mark: - properties
    let name: String
    let emoji: String
    let identifier: UUID // - like a timestamp right then and there
 
    // Mark: - MemberWize
    init(name: String, emoji: String, identifier: UUID = UUID()) {
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    // Mark: - failable
    init?(dictionary: [String: String], identifier: String) {
        guard let name = dictionary[nameKey],
        let emoji = dictionary[emojiKey],
            let identifier = UUID(uuidString: identifier)  else { return nil }
        
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    // Mark: - Dictionary Rep
    var dictionaryRep: [String: Any] {
        let dictionary: [String: Any] = [
        nameKey: name,
        emojiKey: emoji,
        uuidKey: identifier.uuidString
        ]
        return dictionary
    }
    // turn or serialize dictionaryRep into Data
    // return JSON data from our objects
    // Mark: - PUT
    var jsondata: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted )
    }
    
}
