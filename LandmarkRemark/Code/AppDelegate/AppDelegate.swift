//
//  AppDelegate.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 05/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator : MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        startApp()
        
        return true
    }
    
    /**
     Call this function to Start App Flow
     */
    func startApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        coordinator = MainCoordinator(window: window)
        coordinator?.start()
        
    }

}

