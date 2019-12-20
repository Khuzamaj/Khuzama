
import Foundation
import UIKit
import CoreLocation
import MapKit
class InfromationPostingView: UIViewController {
    
    var Coordinate: CLLocationCoordinate2D!
    var Name: String!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var linkTF: UITextField!
    @IBAction func findLocation(_ sender: Any) {
        guard let location = locationTF.text,
        let link = linkTF.text,
            location != "", link != "" else {
          self.Alert(title: "Missing Info", message: "Fill required fields")
                return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coordinate = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
        
    }
    
    
    @IBAction func finish(_ sender: Any) {
        ParseAPI.postStudentLocation(link: linkTF.text ?? " ", locationCoordinate: Coordinate, locationName: Name) { (err) in
            guard err == nil else {
                self.Alert(title: "Error", message: err! as! String)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

