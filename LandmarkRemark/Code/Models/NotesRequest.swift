//
//  NotesRequest.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

struct NotesRequest : Codable {
    var username : String
    var notes : String
    var lat : Double
    var long : Double
    var title : String
    var email : String
    
    private enum CodingKeys : String, CodingKey {
        case username
        case notes
        case lat 
        case long
        case title
        case email
    }
    
    
    init(username : String = "" , notes : String = "", lat : Double = 0.0 , long : Double = 0.0 , title : String = "" , email : String = "") {
        self.username = username
        self.notes = notes
        self.lat = lat
        self.long = long
        self.title = title
        self.email = email
    }
}
