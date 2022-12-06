import Foundation

extension URL {
    static func searchFlickrByKeyword(_ keyword: String) -> URL? {
        let urlFormString = URL(string:"https://api.flickr.com/services/feeds/photos_public.gne?tags=+\(keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Cars")&tagmode=any&format=json&nojsoncallback=1")
        return urlFormString
    }
}

extension FlickrList {
    static func byKeyword(_ keyword: String) -> Resource<FlickrList> {
        guard let url = URL.searchFlickrByKeyword(keyword) else {
            fatalError("keyword = \(keyword) was not found.")
        }
        return Resource(url: url)
    }
}
