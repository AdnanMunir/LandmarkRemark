//
//  AppAlerts.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDelegate{
    func alertOkPressed()
}

protocol LocationAlertDelegate{
    /**
     Delegate to inform that Alert Cancel button is pressed
     */
    func cancelPressed()
    /**
     Delegate to inform that Location is off and move to settings to enable them
     */
    func settingsPressed()
}


final class AppAlerts {
    class func showAlert(message : String,delegate : AlertDelegate? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                if let delegate = delegate {
                    delegate.alertOkPressed()
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("Error in alert")
            }}))
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showLocationDeniedAlert(message : String,delegate : LocationAlertDelegate? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{
            case .default:
                if let delegate = delegate {
                    delegate.cancelPressed()
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("Error in alert")
            }}))
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
            switch action.style{
            case .default:
                if let delegate = delegate {
                    delegate.settingsPressed()
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("Error in alert")
            }}))
        
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
