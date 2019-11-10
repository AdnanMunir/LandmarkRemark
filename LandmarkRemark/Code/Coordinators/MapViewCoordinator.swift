//
//  MapViewCoordinator.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import UIKit

final class MapViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    
    init(navController : UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let mapVC = MapViewController.instantiate(withStoryBoard: .Map)
        let notesTVC = NotesTableViewController.instantiate(withStoryBoard: .Map)
        notesTVC.delegate = mapVC
        mapVC.searchController = UISearchController(searchResultsController: notesTVC)
        mapVC.searchController.searchResultsUpdater = notesTVC
        mapVC.coordinator = self
        mapVC.mapVM = MapViewModel(authService: AuthenticationService(), notesService: NotesService())
        navigationController = UINavigationController(rootViewController: mapVC)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    func moveToLogin() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.changeRootViewToLogin()
    } 
    

    
    
}
