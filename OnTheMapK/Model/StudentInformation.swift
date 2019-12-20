//Specifcations:
//#1:The app contains a StudentInformation struct with appropriate properties for locations and links.
//#2:The struct has an init() method that accepts a dictionary as an argument, or the struct conforms to the Codable protocol.



import Foundation
struct StudentInformation: Codable{
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: String?
    let updatedAt: String?
}
