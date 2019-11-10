//
//  UIStoryboard+Extension.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation

import Foundation
import UIKit

enum Storyboard:String {
    case Authentication
    case Map
}

protocol Storyboardable: AnyObject { }


extension Storyboardable where Self: UIViewController {
    
    
    /**
     Initializes the Controller from storyboard
     */
    static func instantiate(withStoryBoard storyBoard:Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: Self.string) as? Self else {
            fatalError("Could not instantiate storyboard with name: \(storyBoard.rawValue)")
        }
        return vc
    }
}

extension UIViewController: Storyboardable { }
