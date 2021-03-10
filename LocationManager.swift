import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    static var manager = LocationManager()
    
    var geoCoder = CLGeocoder()
    var locationManager = CLLocationManager()
    
    
    static var city: String = ""
    static var address: String = ""
    static var latitude: Double = 0.0
    static var longitude: Double = 0.0
    
    func checkLocation(successCallback: @escaping (String) -> Void, errorCallBack: @escaping (String) -> Void) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
                
            case  .restricted, .denied:
                
                errorCallBack("user denied the permission")
                break
                
            case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
                
                successCallback("getting location")
                getCurrentLocation()
                
            @unknown default:
                
                errorCallBack("Unknown condition")
                
            }
            
        } else {
            
            errorCallBack("user disabled the location")
            
        }
        
    }
    
    func getCurrentLocation() {
        
        locationManager.delegate = self
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()
        
    }
    
    func parseAddress(location: CLLocation, successCallback: @escaping () -> Void) {
        
        LocationManager.city = ""
        
        geoCoder.reverseGeocodeLocation(location) { (response, error) in

            if let name = response?.last?.name {
                print(name)
                LocationManager.address = name
            }
            
            if let subLocality = response?.last?.subLocality {
                print(subLocality)
                LocationManager.address.append(", " + subLocality)
            }
            
            if let locality = response?.last?.locality {
                print(locality)
                LocationManager.city = locality
                LocationManager.address.append(", " + locality)
            }
            
            if let postalCode = response?.last?.postalCode {
                print(postalCode)
                LocationManager.address.append(", " + postalCode)
            }
            
            if let administrativeArea = response?.last?.administrativeArea {
                print(administrativeArea)
                LocationManager.address.append(", " + administrativeArea)
            }
            
            if let country = response?.last?.country {
                print(country)
                LocationManager.address.append(", " + country)
                
            }
            
            successCallback()
            
        }
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let locationArray = locations as NSArray
        
        if let locationObj = locationArray.lastObject as? CLLocation {
            
            let coord = locationObj.coordinate
            
            LocationManager.latitude = coord.latitude
            LocationManager.longitude = coord.longitude
            
            locationManager.stopUpdatingLocation()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "locationUpdated"), object: nil, userInfo: nil)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
    }

}
