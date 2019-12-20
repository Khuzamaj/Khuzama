
import Foundation
import UIKit

class TableTabbedView: UITableViewController {
@IBOutlet weak var TableTabbedView: UITableView!
   var selectedIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (Global.studentLocations == nil){
            loadLocations()
        } else {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
       logOut()
    }
    
    
    @IBAction func newPin(_ sender: Any) {
         pin(SegueID: "tableToPost")
    }
    
    @IBAction func refresh(_ sender: Any) {
         loadLocations()
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
           
        }
    

        
        func numberOfSections(in TableTabbedView: UITableView) -> Int {
            return 1
        }
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Global.studentLocations?.count ?? 0
        }
    
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = TableTabbedView.dequeueReusableCell(withIdentifier: "cellID")!
            
            cell.textLabel?.text = Global.studentLocations?[indexPath.row].firstName
            cell.imageView?.image = UIImage(named: "pin")
            cell.detailTextLabel?.text = Global.studentLocations?[indexPath.row].mediaURL
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath.row
            performSegue(withIdentifier: "showDetail", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }

 

}
