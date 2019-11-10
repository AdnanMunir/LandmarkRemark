//
//  MapVC.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    weak var coordinator : MapViewCoordinator?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelUsername: UILabel!
    var noteView : NoteView?
    var searchController: UISearchController!
    
    
    // Bindings
    var mapVM : MapModeling! {
        didSet {
            self.mapVM.moveToLogin = {[weak self] in
                self?.coordinator?.moveToLogin()
            }
            
            self.mapVM.initializeView = {[weak self] in
                self?.initializeView()
            }
            
            self.mapVM.showError = { message in
                AppAlerts.showAlert(message: message)
            }
            
            self.mapVM.addAnnotation = {[weak self] note in
                self?.addAnnotation(note: note)
            }
            
            self.mapVM.removeAllAnnotations = {[weak self] in
                self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
            }
            
            self.mapVM.startIndicator = {[weak self] in
                self?.activityIndicator.startAnimating()
                self?.view.isUserInteractionEnabled = false
            }
            
            self.mapVM.stopIndicator = {[weak self] in
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            }
        }
    }
   
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVM.viewDidLoad()
    }
    
    //MARK: - Helper Functions
    
    /**
     Call this function to setup the Map & Search Controller
     */
    private func initializeView() {
       
        labelUsername.text = mapVM.getUserTitle()
        setupSearchController()
        LocationManager.sharedInstance.delegate = self
        configureMap()
    }
    
    /**
     Call this function to Configure Search Controller for displaying search results according to Username / Notes Text
     */
    private func setupSearchController() {
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for notes"
        navigationItem.titleView = searchController?.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Search by UserName" , "Seaarch by Notes"]
        searchBar.scopeBarBackgroundImage = UIImage.imageWithColor(color: navigationController?.navigationBar.backgroundColor ?? UIColor.clear)
        searchBar.delegate = self
        
        definesPresentationContext = true
    }
    
    /**
     Call this function for mapView Settings
     */
    private func configureMap() {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    /**
     Call this function to add annotation on Map with respect to Note
     */
    private func addAnnotation(note : Note) {
        let loc = MKPointAnnotation()
        loc.title = "\(note.username ?? "N/A") : \(note.title ?? "N/A") "
        loc.coordinate = CLLocationCoordinate2D(latitude: note.lat ?? 0.0, longitude: note.long ?? 0.0)
        loc.subtitle = note.note
        mapView.addAnnotation(loc)
    }
    
    
    /**
     Call this function to focus map on specific location
     */
    private func focusMapOnLocation(lat : Double , long : Double ) {
        let viewRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(viewRegion, animated: false)
    }

    //MARK: - User Interaction
    @IBAction func noteButtonAction(_ sender: Any) {
        noteView = NoteView(frame: view.frame)
        noteView?.delegate = self
        noteView?.noteViewVM =  mapVM.getNotesVM()
        view.addSubview(noteView!)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        mapVM.logout()
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        mapVM.changeNotesType(type: segmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func userLocationButtonAction(_ sender: Any) {
        focusMapOnLocation(lat: mapView.userLocation.coordinate.latitude, long: mapView.userLocation.coordinate.longitude)
    }
    
    @IBAction func refreshMapButtonAction(_ sender: Any) {
        mapVM.reloadMap()
    }
    
    
    
}


//MARK: - Location Manager Delegate
extension MapViewController : LocationManagerDelegate {
    func userLocation(latitude: Double, longitude: Double) {
        //Refresh Map after every 1 Kilometer automatically for new notes/updates
        mapVM.reloadMap()
    }
    
}


//MARK: - Map View Delegate
extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            
        } else {
            annotationView!.annotation = annotation
        }
        
        let subtitleView = UILabel()
        subtitleView.font = subtitleView.font.withSize(12)
        subtitleView.numberOfLines = 0
        subtitleView.text = annotation.subtitle!
        annotationView!.detailCalloutAccessoryView = subtitleView
        
        return annotationView
    }
}


//MARK: - NoteView Delegates
extension MapViewController : NoteViewDelegate {
    func noteAddedSuccessfully() {
        dissmissNoteView()
        mapVM.reloadMap()
        
    }
    
    func dissmissNoteView() {
        noteView?.removeFromSuperview()
    }
    
}


//MARK: - NotesTableVC Delegates
extension MapViewController : NotesTableViewControllerDelegate {
    func moveToNote(note: Note) {
        searchController.dismiss(animated: true) { [weak self] in
            self?.focusMapOnLocation(lat: note.lat ?? 0.0, long: note.long ?? 0.0)
        }
    }
    
    
    func searchNotesWithText(searchText: String, completion: ([Note]) -> Void) {
        mapVM.filterNotes(searchText: searchText, completion: completion)
    }

}


//MARK: - Search Bar Delegate
extension MapViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        mapVM.changeSearchType(type: selectedScope)
        searchController.dismiss(animated: true, completion: nil)
    }
}
