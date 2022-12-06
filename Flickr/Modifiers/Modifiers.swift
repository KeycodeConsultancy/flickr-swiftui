import Foundation
import SwiftUI

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(maxWidth: 100, maxHeight: 100)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
