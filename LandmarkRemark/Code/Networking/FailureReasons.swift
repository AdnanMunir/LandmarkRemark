//
//  FailureReasons.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

enum FailureReason {
    case other
    case reason(error:String)
}

extension FailureReason: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .reason(let error): return error
        case .other: return "Something went wrong."
        }
    }
}
