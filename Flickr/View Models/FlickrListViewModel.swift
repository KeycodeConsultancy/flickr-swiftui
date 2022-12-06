import Foundation
import SwiftUI

@MainActor
class FlickrListViewModel: ObservableObject {
    @Published var flickrs: [FlickrViewModel] = []
    var service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchFlickrsWebService(_ keyword: String) async throws {
        do {
            let flickrs = try await self.service.load(FlickrList.byKeyword(keyword))
            self.flickrs = flickrs.items?.map(FlickrViewModel.init) ?? []
        } catch {
            print(error)
        }
    }
    
    func fetchFlickrsLocalService(_ keyword: String) async throws  {
        do {
            let flickrs = try await LocalService().load(FlickrList.byKeyword(keyword))
            self.flickrs = flickrs.items?.map(FlickrViewModel.init) ?? []
            
        } catch {
            print(error)
        }
    }
}

struct FlickrViewModel: Identifiable  {
    fileprivate var flickrItem: FlickrItem
    
    init(flickrItem: FlickrItem) {
        self.flickrItem = flickrItem
    }
    
    var id: UUID {
        flickrItem.id
    }
    
    var title: String {
        flickrItem.title ?? ""
    }
    
    var authorID: String {
        flickrItem.authorID ?? ""
    }
    
    var author: String {
        flickrItem.author ?? ""
    }
    
    var media: URL? {
        URL(string: flickrItem.media?.m ?? "")
    }
    
    var tags: String {
        flickrItem.tags ?? ""
    }
    
    var dateTaken: String {
        flickrItem.dateTaken ?? ""
    }
    
    func convertNSDataToImage(url: URL) async -> UIImage {
         let imageData : NSData = NSData.init(contentsOf: url as URL)!
         let newImage = UIImage(data: imageData as Data)!
         return newImage
     }
}
