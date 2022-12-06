import XCTest
import SwiftUI
@testable import Flickr

@MainActor
 class FlickrTests: XCTestCase {
     
    override func setUp() {
        super.setUp()
    }
     
     func testFetchFlickrs() async {
        do {
            @ObservedObject var flickrListViewModel = FlickrListViewModel(service: LocalService())
            _ = try await flickrListViewModel.fetchFlickrsLocalService("gardenning")
            XCTAssertEqual(flickrListViewModel.flickrs[0].title,"Garden fellow local service")
            XCTAssertEqual(flickrListViewModel.flickrs[0].dateTaken,"2021-09-12T09:25:14-08:00")
            XCTAssertEqual(flickrListViewModel.flickrs[0].media?.absoluteString,"https://live.staticflickr.com/65535/51461944318_eeef05c059_m.jpg")
            XCTAssertEqual(flickrListViewModel.flickrs[0].author,"nobody@flickr.com (\"nicolas.devienne\")")
            XCTAssertEqual(flickrListViewModel.flickrs[0].tags,"garden mantis gardenning mante jardin insecte close macro bug")
            XCTAssertEqual(flickrListViewModel.flickrs.count,20)
        } catch {
            print(error.localizedDescription.description)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
