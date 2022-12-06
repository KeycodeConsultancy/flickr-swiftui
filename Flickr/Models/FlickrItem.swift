import Foundation

struct FlickrItem: Codable, Identifiable {
    let id = UUID()
    let authorID: String?
    let media: Media?
    let tags: String?
    let title: String?
    let dateTaken: String?
    let author:String?

    enum CodingKeys: String, CodingKey {
        case dateTaken = "date_taken"
        case author
        case authorID = "author_id"
        case media
        case tags
        case title
    }
}
