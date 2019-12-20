import UIKit
import MapKit

class MapView: UIViewController, MKMapViewDelegate {
    //OUTLETS
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (Global.studentLocations == nil){
            loadLocations()
        } else {
            DispatchQueue.main.async{
               self.updatePin()
            }
        }
    }
    
    @IBAction func newPin(_ sender: Any) {
      pin(SegueID: "NewPin")
    }
    @IBAction func refresh(_ sender: Any) {
        loadLocations()
    }
    //Logout tapped
    @IBAction func logout(_ sender: Any) {
         logOut()
    }
 
        
    func updatePin() {//H calls it updateAnnotations
        let locations = [StudentInformation]()
        var annotations = [MKPointAnnotation]()
        for dictionary in locations {
            guard let dictionaryLatitude = dictionary.latitude, let dictionaryLongoitude = dictionary.longitude else {continue}
            let lat = CLLocationDegrees(dictionaryLatitude)
            let long = CLLocationDegrees(dictionaryLongoitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        self.MapView.addAnnotations(annotations)
            }
    
    
    
     //MKMapViewDelgate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
   
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    

func loadLocations(){
    ParseAPI.getStudentLocations{(locations, error)  in
        guard let data = locations else {
            self.Alert(title: "Error", message: "Check your internet connection and try again later")
            return
        }
        guard data.count > 0 else {
            self.Alert(title: "Error", message: "No pins")
            return
        }
        Global.studentLocations = locations!
       self.updatePin()
}
}
}
