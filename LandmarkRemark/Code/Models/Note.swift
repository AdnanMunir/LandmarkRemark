//
//  Note.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 07/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation


struct Note : Decodable {
    var title : String?
    var note : String?
    var lat : Double?
    var long : Double?
    var email : String?
    var username : String?
    
    enum CodingKeys : String,CodingKey {
        case title
        case note
        case lat
        case long
        case email
        case username 
    }
    
}


