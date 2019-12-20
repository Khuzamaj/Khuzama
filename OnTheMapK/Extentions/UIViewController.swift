
import Foundation
import UIKit

extension UIViewController {
    func  Alert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        present(ac, animated: true, completion: nil)
    }
   
    func pin(SegueID: String){
    if UserDefaults.standard.value(forKey: "studentLocation") != nil {
    self.Alert(title: "error", message: "You have already posted a student location.")
    performSegue(withIdentifier: SegueID, sender: self)
    }
    else{
    performSegue(withIdentifier: SegueID, sender: self)
    }
}
    
    func logOut(){
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Logout", style: .destructive, handler: {(_) in
            UdacityAPI.deleteSession{ (error) in
                guard error == nil else {
                    self.Alert(title: "Error", message: error! as! String)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}
