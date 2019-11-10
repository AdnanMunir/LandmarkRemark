//
//  LocationManager.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationManagerDelegate:class {
    func userLocation(latitude:Double,longitude:Double)
}

class LocationManager:NSObject {
    static var sharedInstance = LocationManager()
    var locationManager = CLLocationManager()
    weak var delegate : LocationManagerDelegate?
    private override init() {}
    
    func startLocationUpdates() {
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = false
        //locationManager.allowsBackgroundLocationUpdates = true
        locationManager.activityType = .automotiveNavigation
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    private func showAlert() {
        AppAlerts.showLocationDeniedAlert(message: "To use location you must turn on Location in the Location Services Settings", delegate: self as LocationAlertDelegate)
    }
    
}

//MARK: - Location Delegates

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        switch CLLocationManager.authorizationStatus() {
        case .denied,.restricted,.notDetermined:
            self.locationManager.stopUpdatingLocation()
            showAlert()
            break
        default:
            break
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            showAlert()
        } else if status == .authorizedAlways {
            startLocationUpdates()
        } else if status == .notDetermined {
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let dateStamp = location?.timestamp
        let recentStamp = dateStamp?.timeIntervalSinceNow
        if fabs(recentStamp!) < 15.0 {
            if let loc = location {
                delegate?.userLocation(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
            }
        }
    }
}

extension LocationManager: LocationAlertDelegate {
    func cancelPressed() {
        showAlert()
    }
    
    func settingsPressed() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            return
        }
    }
}

