//
//  UIImage+Extension.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 08/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     Converts the color in Image
     */
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
