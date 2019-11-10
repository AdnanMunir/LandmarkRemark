//
//  APIResponse.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

struct APIResponse : Decodable {
    let error: String?
    let success : SucessResponse?
    
    private enum CodingKeys:String,CodingKey {
        case error
        case success = "SUCCESS"
    }
}

struct SucessResponse:Decodable {
    var response:String?
    
    private enum CodingKeys:String,CodingKey {
        case response
    }
}
