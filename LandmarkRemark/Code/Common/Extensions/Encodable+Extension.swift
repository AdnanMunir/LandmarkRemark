//
//  Encodable+Extension.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 08/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

extension Encodable {
    /**
     Converts the Object Model into Dictionary
     */
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
