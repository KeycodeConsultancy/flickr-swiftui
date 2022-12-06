import Foundation

struct FlickrList: Codable {
    let items: [FlickrItem]?
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
