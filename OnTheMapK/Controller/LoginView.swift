
import Foundation
import UIKit

class LoginView: UIViewController{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    //Login button is pressed
    @IBAction func login(_ sender: Any) {
        //Check to see if the textfields are empty
        if (email.text!.isEmpty) || (password.text!.isEmpty) {
            
        Alert(title: "Empty Textfields", message: "Please fill the required fields")
            
        } else {
          // Failure to connect
            UdacityAPI.postSession(with: email.text!, password: password.text!) { (loginSuccess, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        self.Alert(title: "Failure To Connect", message: "There was an error performing your request")
                    }
                    //Incorrect credentials
                    if !(loginSuccess != nil) {
                        self.Alert(title: "Login Error", message: "Incorrect email or password")
                    } else {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapView
                        self.navigationController!.pushViewController(controller, animated: true)
                    }
                }}
          
        }
    
        
}

}
