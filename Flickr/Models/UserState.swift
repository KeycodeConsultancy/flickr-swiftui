import Foundation
import SwiftUI

struct UserNavigationState {
    var backButtonPressedOnDetailView: Bool?
    var imageData: UIImage?
}

class UserState: ObservableObject {
    @Published var userNavigationState: UserNavigationState!
    init() {
         userNavigationState = UserNavigationState()
    }
}
