//
//  Class+Extension.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

extension NSObject {
    /**
     Variable gives the name of the class
     */
    class var string : String {
        get {
            return String(describing: self) // gives name of the class
        } set (key) {
            
        }
    }
}
