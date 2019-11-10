//
//  Coordinator.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var navigationController : UINavigationController {get set}
    var childCoordinators : [Coordinator] {get set}

    func start()
}

extension Coordinator {
    /**
     Call this function to Remove Child form parent coordinators child coordinators array
     */
    func childDidFinish(_ child : Coordinator) {
        for (index,coordinator) in  childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
