import SwiftUI

@main
struct FlickrApp: App {
    static let webService = WebService()
    var body: some Scene {
        WindowGroup {
            ContentView(service: FlickrApp.webService)
        }
    }
}
