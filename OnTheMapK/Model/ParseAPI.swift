import UIKit
import MapKit
class ParseAPI
{
    // GET student locations
    static func getStudentLocations(completion: @escaping ([StudentInformation]?, Error?)-> ()){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            }
            //convert data returned into a dictionary
            let dict = try! JSONSerialization.jsonObject(with: data!, options:[])as! [String:Any]
            guard let results = dict["results"] as? [[String:Any]] else {return}
            let resultsData = try! JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
            let studentLocations = try! JSONDecoder().decode([StudentInformation].self, from: resultsData)
            Global.studentLocations = studentLocations
            completion(studentLocations, nil)
        }
        task.resume()
    }
    // POST student location (insert a new pin)
    static func postStudentLocation(link: String, locationCoordinate: CLLocationCoordinate2D, locationName:String,completion: @escaping (Error?)-> ()){
    var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(locationName)\",\"Mountain View, CA\", \"mediaURL\": \"\(link)\",\"latitude\":\(locationCoordinate.latitude),\"longitude\":\(locationCoordinate.longitude)}".data(using: .utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        if error != nil {
            completion(error)
            return
        }
        print(String(data: data!, encoding: .utf8)!)
        completion(nil)
    }
    task.resume()
    }
    //PUT student location(update an existing student location)
    
    
}
